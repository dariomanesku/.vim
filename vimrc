call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

set number

set ic

set hidden

set nocompatible

set wildmenu

set hlsearch

nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

set virtualedit=all
colorscheme xoria256

"clang_complete settings
let g:clang_complete_auto = 1
let g:clang_complete_copen = 0
let g:clang_hl_errors = 1
let g:clang_periodic_quickfix = 0
let g:clang_snippets = 1
let g:clang_conceral_snippets = 1
let g:clang_user_options = '-I/usr/include/c++/4.6 -I/usr/include/c++/4.6/x86_64-linux-gnu/. -I/usr/include/c++/4.6/backward -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include -I/usr/local/include -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include-fixed -I/usr/include/x86_64-linux-gnu -I/usr/include'
