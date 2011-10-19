call pathogen#infect()
call pathogen#helptags()
set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax on

set hidden

set wildmenu

nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

set virtualedit=all
