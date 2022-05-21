setxkbmap -layout br,dvorak -option "grp:alt_caps_toggle"
xsetroot -cursor_name left_ptr &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

xsettingsd &

# needed for vscode to login properly.
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# Download and set wallpapers from Reddit
# Only one first, to start X faster
python $HOME/dotfiles/get_reddit_wallpaper.py -r wallpapers -n 1 -o /tmp/reddit -s top -t week

mkdir /tmp/wpg
mkdir /tmp/wpg/wallpapers
mkdir /tmp/wpg/schemes
mkdir /tmp/wpg/samples

shopt -s extglob
wpg -a /tmp/reddit/*/!(*.json)
wpg -m

# Download some more wallpapers in the background
( python $HOME/dotfiles/get_reddit_wallpaper.py -r wallpapers \
    -n 10 -o /tmp/reddit -s top -t week \
    && wpg -a /tmp/reddit/*/!(*.json) ) &

exec bspwm
