#!/usr/bin/python3
import argparse, requests, re, json
from datetime import datetime
from urllib.parse import urlparse
from pathlib import Path
import logging

REDDIT_MAX_LIMIT = 100
METADATA_PATHSTEM = 'metadata'
KNOWN_IMG_EXTENSIONS = {'.png', '.jpg', '.jpeg', '.bmp'}


def parse_args():
    parser = argparse.ArgumentParser(
        description=\
            'Fetch images from Reddit. Example:\n\t'\

            '$ python3 {Path(__file__).name} -r itookapicture CozyPlaces'\
            ' -s top -n 12 -t all -o ./folder/with/my/reddit/pictures'
    )
    parser.add_argument('-r', '--subreddit', nargs='+', required=True,
                        help='Exact name of the subreddits you want to fetch '\
                             'from')
    parser.add_argument('-n', '--number', type=int, default=1,
                        help='Number of images to fetch from each subreddit')
    parser.add_argument('-s', '--sort',
                        choices=('hot', 'top', 'new', 'random', 'rising'),
                        default='hot',
                        help='Method for sorting posts')
    parser.add_argument('-t', '--timespan',
                        choices=('hour', 'day', 'week', 'month', 'year', 'all'),
                        default='day',
                        help='Specify the time span of top posts')
    parser.add_argument('-o', '--out', type=Path, default=Path('.'),
                        help='The directory where to save the pictures and th'\
                             'eir metadata. Defaults to the current directory.')
    parser.add_argument('--nsfw', action='store_true',
                        help='Include NSFW (not safe for work) images. This'\
                             'behaviour is disabled by default.')
    parser.add_argument('--nsfw-only', action='store_true',
                        help='Fetch only NSFW (not safe for work) images.')
    parser.add_argument('--loglevel', default='warning',
                        help='Set the logging level (e.g. warning, info, debu'\
                             'g).')

    return parser.parse_args()


def next_available_path(path: Path) -> Path:
    path = Path(path)

    while path.exists():
        count_match = re.search(r"(.*?)(\d+)$", path.stem)
        if count_match:
            prefix, count = count_match.groups()
        else:
            prefix, count = path.stem+'_', 0

        path = path.with_stem(prefix+str(int(count) + 1))

    return path


def download_pictures(
        data, outdir, nsfw=False, nsfw_only=False):
    """Download pictures from the children attribute of reddit JSON response.
    """
    outdir = Path(outdir).resolve()
    metadata = []
    downloaded_count = 0
    total = len(data)

    for count, current_post in enumerate(data):
        current_post = current_post['data']

        # Ignore NSFW post if you didn't ask for it.
        if current_post['over_18']:
            if not nsfw:
                logging.info(
                    f"Ignored NSFW content from {current_post['permalink']}")
                continue
        # Ignore SFW post if you required NSFW only.
        elif nsfw_only:
            logging.info(
                f"Ignored SFW content from {current_post['permalink']}")
            continue

        image_url = current_post['url']
        current_outpath = outdir/urlparse(image_url).path.strip('/\\')

        if current_outpath.suffix not in KNOWN_IMG_EXTENSIONS:
            logging.info(
                f"Ignored post ({current_post['permalink']}) with unknown "\
                f"image extension: {current_post['url']}")
            continue

        if current_outpath.exists():
            logging.info(
                f"Ignored post ({current_post['permalink']}), image "\
                f"found in local system: {current_outpath}")
            continue

        # allow_redirects=False prevents thumbnails denoting removed images
        # from getting in.
        image_response = requests.get(image_url, allow_redirects=False)

        if not image_response.ok:
            logging.error(
                f"Unsuccessful response from page {current_post['permalink']}"\
                f": {image_response.status_code} (image not found).")
            continue

        print(f"({downloaded_count}/{count}/{total}) "\
              f"Downloading image from {current_post['permalink']}")

        with current_outpath.open('wb') as outfile:
            outfile.write(image_response.content)
            downloaded_count += 1
        
        metadata.append({
            "post": current_post["permalink"],
            "subreddit": current_post["subreddit"],
            "url": current_post["url"],
            "local_path": str(current_outpath),
            "time": datetime.now().isoformat(),
        })
    
    return downloaded_count, metadata


def download_from_subreddit(
        subreddit, outdir, number, sort, timespan, nsfw, nsfw_only
):
    outdir = Path(outdir)
    outdir.mkdir(exist_ok=True)

    # TODO: Better metadata management.
    path_metadata = (outdir/METADATA_PATHSTEM).with_suffix('.json')
    if path_metadata.exists():
        with path_metadata.open('r') as file_metadata:
            metadata = json.load(file_metadata)
    else:
        metadata = []

    downloads_left = number
    url = f"https://www.reddit.com/r/{subreddit}/{sort}.json"

    request_params = dict(
        after=None,
        t=timespan,
        limit=min(downloads_left, REDDIT_MAX_LIMIT), # # of posts to request
    )
    headers = {'User-agent': 'wpfetch'}

    while downloads_left:
        logging.info(f"Sending request to {url}...")
        response = requests.get(url, params=request_params, headers=headers)

        if not response.ok:
            raise requests.RequestException(
                f"Got {response.status_code} response from {response.url}")

        page_data = response.json()['data']
        request_params['after'] = page_data['after']

        downloaded_count, new_metadata = download_pictures(
            page_data['children'],
            outdir=outdir,
            nsfw=nsfw,
            nsfw_only=nsfw_only,
        )

        metadata += new_metadata
        with path_metadata.open('w') as file_metadata:
            json.dump(metadata, file_metadata, indent=2)

        downloads_left -= downloaded_count
        request_params['limit'] = min(downloads_left, REDDIT_MAX_LIMIT)

        print(f"Downloaded {downloaded_count} images, {downloads_left} left.")


def main(**kwargs):
    outdir = Path(kwargs['out'])
    outdir.mkdir(exist_ok=True)

    for subreddit in kwargs['subreddit']:
        print(f"Downloading {kwargs['number']} images from r/{subreddit}...")

        download_from_subreddit(
            subreddit=subreddit,
            outdir=outdir/subreddit,
            number=kwargs['number'],
            sort=kwargs['sort'],
            timespan=kwargs['timespan'],
            nsfw=kwargs['nsfw'],
            nsfw_only=kwargs['nsfw_only'],
        )


if __name__ == '__main__':
    args = parse_args()
    logging.basicConfig(level=args.loglevel.upper())
    main(**vars(args))
