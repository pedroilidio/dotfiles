let python_highlight_all=1
syntax on

" set lighline theme (in yor lightline config)
" let g:lightline = { 'colorscheme': 'wal' }
let g:lightline = { 'colorscheme': 'wombat' }

set background=dark
colorscheme wpgtkAlt

" custom Esc
imap jf <Esc>
imap fj <Esc>
imap jk <Esc>
imap kj <Esc>
imap ., <Esc>
imap ,. <Esc>

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


" show highlight group under cursor on <C-i>
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" nnoremap <C-i> :call SynGroup()<ENTER>

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
