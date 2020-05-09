let python_highlight_all=1
syntax on

set background=dark
colorscheme jupiter

imap jf <Esc>
imap fj <Esc>

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

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nnoremap <C-i> :call SynGroup()<ENTER>
