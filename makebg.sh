#!/bin/sh
# Use: makebg VIMSERVERNAME MAKEPRG LOGFILE
# Save this file as: ~/.vim/makebg.sh
# Make a vim script in the project root dir as folowing:
#
#let s:root_dir      = expand("<sfile>:p:h")
#let s:log_file      = s:root_dir."/make.log"
#let s:make_action   = "all"
#let s:make_command  = "make -R -C ".s:root_dir." ".s:make_action
#
#function! Build()
#	let l:curr_dir = getcwd()
#	exec 'cd' s:root_dir
#	exec "silent call system('~/.vim/makebg.sh ".v:servername." \"".s:make_command."\" ".s:log_file."')"
#	normal k
#	exec 'cd' l:curr_dir
#endfunc

# Example .ide.vim file:
#
#   if has("unix")
#       set makeprg=make
#
#       let s:proj_name   = "proj_name"
#       let s:proj_root   = expand("<sfile>:p:h")
#       let s:makebg_file = s:proj_root."/.makebg.sh"
#       let s:log_file    = s:proj_root."/make.log"
#
#       function! Build(compiler)
#           let s:make_action  = "linux-".a:compiler."-debug64"
#           let s:make_command = "make OPTS=-j8 ".s:proj_root." ".s:make_action
#           let s:build_action = "!".s:makebg_file." ".v:servername." \"".s:make_command."\" ".s:log_file
#           let curr_dir = getcwd()
#           exec 'cd' s:proj_root
#           exec s:build_action
#           exec 'cd' curr_dir
#       endfunc
#
#       function! Execute(compiler)
#           let s:runtime_dir  = s:proj_root."/runtime"
#           let s:exec_action  = "!../_build/linux64_".a:compiler."/bin/".s:proj_name."Debug"
#           let curr_dir = getcwd()
#           exec 'cd' s:runtime_dir
#           exec s:exec_action
#           exec 'cd' curr_dir
#       endfunc
#
#       nmap ,rr :call Build("clang")<cr><cr>
#       nmap ,rb :call Build("gcc")<cr><cr>
#
#       nmap ,ee :call Execute("clang")<cr>
#       nmap ,eb :call Execute("gcc")<cr>
#   endif
#

tempfile="$PWD/.make.tmp"
currentdir=${PWD##*/}
server="${1:-VIM}"
makeprg="${2:-make}"
logfile="${3:-make.log}"

{
	echo '-----------------------------------------' >> "$tempfile"
	date >> "$tempfile"
	echo '-----------------------------------------' >> "$tempfile"

	exec 3<> $tempfile
	$makeprg >&3 2>&1
	success=$?
	exec 3>&1

	sed -i 's/In file included from //' $tempfile

	touch "$logfile";
	#cat "$logfile" >> "$tempfile" #uncomment this if you want to keep logfile history
	mv "$tempfile" "$logfile";

	#vim --servername "$server" --remote-send "<Esc>:cgetfile $logfile<CR>" ;

	#if [ $success -eq 0 ]; then
	#	vim --servername "$server" --remote-send "<Esc>:redraw | :echo \"Build sucessful.\"<CR>" ;
	#else
	#	vim --servername "$server" --remote-send "<Esc>:redraw | :echo \"Build ERROR!\"<CR>" ;
	#fi

	vim --servername "$server" --remote-expr "CGetFile('$logfile')" ;
	vim --servername "$server" --remote-expr "Redraw()";

	if [ $success -eq 0 ]; then
		vim --servername "$server" --remote-expr "PrintBuildSuccessful()" ;
	else
		vim --servername "$server" --remote-expr "PrintBuildError()" ;
	fi
} &
