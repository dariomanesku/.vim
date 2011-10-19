call pathogen#helptags()
call pathogen#infect()
syntax on
filetype plugin indent on

set number

set hidden

set nocompatible

set wildmenu

nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

set virtualedit=all
