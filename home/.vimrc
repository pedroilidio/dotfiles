let python_highlight_all=1
syntax on

set background=dark
colorscheme jupiter

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

" enable lighline theme
let g:jupiter_lightline = 1
" set lighline theme (in yor lightline config)
let g:lightline = { 'colorscheme': 'jupiter' }

" show highlight group under cursor on <C-i>
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nnoremap <C-i> :call SynGroup()<ENTER>

let g:slime_target = "kitty"
