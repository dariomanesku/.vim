.PHONY: mac linux windows update colors

default:
	@echo "Hello :) RTFM!"

mac: linux

linux:
	ln -s ~/.vim/vimrc ~/.vimrc	> /dev/null 2>&1 || true
	cd ~/.vim
	mkdir bundle
	git clone https://github.com/gmarik/vundle.git bundle/vundle

windows:
	ln -s ~/vimfiles/vimrc ~/_vimrc	> /dev/null 2>&1 || true
	ln -s ~/vimfiles/vimrc ~/.vimrc	> /dev/null 2>&1 || true
	cd ~/vimfiles
	mkdir bundle
	git clone https://github.com/gmarik/vundle.git bundle/vundle
