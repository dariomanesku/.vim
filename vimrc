call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

set number

set ic

set hidden

set nocompatible

set wildmenu
set wildmode=list:longest "shell like behavior

set title

set hlsearch

set ignorecase
set smartcase

"Use English for spell checking but don't enable it by default
set spl=en spell
set nospell

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

"gundo settings
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
let g:gundo_close_on_revert = 0 "set this to 1 to automatically close the Gundo windows when reverting.

"ctags settings
set tags=tags;/

"remap ` to '
nnoremap ' `
nnoremap ` '

"map leader to ,
let mapleader = ","

"store temporary files in a central folder 
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

"scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"clear highlight fast
nmap <silent> <leader>n :silent :nohlsearch<CR>

"show non-visual chars
set listchars=tab:>-,trail:',eol:$
nmap <silent> <leader>s :set nolist!<CR>

