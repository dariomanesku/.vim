call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

set number

set ic

set hidden

set nocompatible

set wildmenu

nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

set virtualedit=all
colorscheme xoria256
