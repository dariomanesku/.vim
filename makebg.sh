#!/bin/sh
# Use: makebg VIMSERVERNAME MAKEPRG MAKEEF
# Save this file as: ~/.vim/makebg.sh
# Make a vim script in the project root dir as folowing:
#
# let proj_root     = expand("<sfile>:p:h")
# let build_target  = "linux-gcc-example01"
# let log_file      = proj_root."/make.log"
# let make_command  = "make -R -C ".proj_root." ".build_target"
# let app_path      = proj_root."/build/linux-gmake-gcc/x64-Debug/bin/example01"
# nmap ,rr :w<cr>:execute "!~/.vim/makebg.sh " .v:servername. " \"".make_command."\" ".log_file<cr><cr>
# nmap ,ee :w<cr>:execute "!~/.vim/makerunbg.sh ".v:servername." \"".make_command."\" ".log_file. " ".app_path<cr><cr>

server="${1:-VIM}"
makeprg="${2:-make}"
makeef="${3:-make.log}"
tempfile="$PWD/.make.tmp"

{
  touch "$makeef";
  echo '-----------------------------------------' >> "$tempfile"
  date >> "$tempfile"
  echo '-----------------------------------------' >> "$tempfile"

  # sed removes some words to prevent vim from misparsing a filename
  exec 3<> $tempfile
  $makeprg >&3 2>&1
  success=$?
  exec 3>&1
  sed -i 's/In file included from //' $tempfile 
  # sed -i '/\[.*\]/d' $tempfile;
  # $makeprg 2>&1 | sed -e's/In file included from //' | sed -e'/make.*/d' >> "$tempfile";


  cat "$makeef" >> "$tempfile"
  mv "$tempfile" "$makeef";
  vim --servername "$server" --remote-send "<Esc>:cgetfile $makeef<CR>" ;

  if [ $success -eq 0 ]; then
      vim --servername "$server" --remote-send "<Esc>:redraw | :echo \"Build sucessful.\"<CR>" ;
  else
      vim --servername "$server" --remote-send "<Esc>:redraw | :echo \"Build ERROR!\"<CR>" ;
  fi

} &
