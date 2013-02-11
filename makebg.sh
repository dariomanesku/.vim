#!/bin/sh
# Use: makebg VIMSERVERNAME MAKEPRG MAKEEF
# Save this file as: ~/.vim/makebg.sh
# Inside Vim, use the mappings:
# nmap ,bb :w<cr>:execute "!~/.vim/makebg.sh"<cr><cr>

server="${1:-VIM}"
makeprg="${2:-make}"
makeef="${3:-make.log}"
makeef="${makeef#$PWD/}"    # remove path, if present

{
  touch "$makeef";
  echo '-----------------------------------------' >> ".$makeef"
  date >> ".$makeef"
  echo '-----------------------------------------' >> ".$makeef"
  # sed removes some words to prevent vim from misparsing a filename
  $makeprg 2>&1 | sed -e's/In file included from //' >> ".$makeef";
  # $makeprg 2>&1 >> ".$makeef";
  cat "$makeef" >> ".$makeef"
  mv ".$makeef" "$makeef";
  vim --servername "$server" --remote-send \
    "<Esc>:cgetfile $PWD/$makeef<CR><CR>" ;
  # vim --servername "$server" --remote-send \
  #   "<Esc>:copen<CR>" ;
} &
