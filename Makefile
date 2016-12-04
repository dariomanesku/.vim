.PHONY: mac linux windows update colors

default:
	@echo "Hello :) RTFM!"

mac: linux

linux:
	ln -s ~/.vim/vimrc ~/.vimrc > /dev/null 2>&1 || true
	mkdir .undodir
	mkdir .tmp
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

windows:
	ln -s ~/vimfiles/vimrc ~/_vimrc > /dev/null 2>&1 || true
	mkdir _tmp
	mkdir _undodir
