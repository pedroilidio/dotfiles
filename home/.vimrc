" remap leader to ç
" let mapleader="ç"
map Ç <leader>
map ç <leader>

" Set timeout for waiting for key combo
set timeoutlen=200
nnoremap <leader>a 1gt
nnoremap <leader>s 2gt
nnoremap <leader>d 3gt
nnoremap <leader>f 4gt
nnoremap <leader>g 5gt
nnoremap <leader>w :tabclose<CR>
nnoremap <leader>t :tabe<Space>

nnoremap <leader>h :tabfirst<CR>
nnoremap <leader>j :tabnext<CR>
nnoremap <leader>k :tabprev<CR>
nnoremap <leader>l :tablast<CR>
nnoremap <leader>J :tabm<Space>+1<CR>
nnoremap <leader>K :tabm<Space>-1<CR>

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <leader><leader> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <leader><leader> :exe "tabn ".g:lasttab<cr>


colorscheme wpgtkAlt

let python_highlight_all=1
syntax on

" folding
set foldmethod=indent   
set foldnestmax=10
set foldlevel=0
set foldminlines=4
set foldnestmax=2
nnoremap <space> za
vnoremap <space> zf

" set lighline theme (in yor lightline config)
" let g:lightline = { 'colorscheme': 'wal' }
let g:lightline = { 'colorscheme': 'wombat' }

set background=dark

" custom Esc
imap jf <Esc>
imap fj <Esc>

" tab
set tabstop=4 
set shiftwidth=4
set expandtab
set autoindent

" Numbering
"set number relativenumber
set nu rnu

" Background color fix
" set t_ut=""

set laststatus=2

let g:slime_target = "kitty"

" '.' is current file location.
set autochdir


" MARKDOWN STUFF
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'

" markdown-preview
" I've created chromium-app in .bashrc
"let g:mkdp_browser = 'chromium-app'
let g:mkdp_browserfunc = 'OpenURL'
let g:mkdp_echo_preview_url = 1
let g:mkdp_markdown_css = expand('~/ricing/markdown_style.css')

function OpenURL(url)
    execute "!chromium" "--app=" . a:url
endfunction
