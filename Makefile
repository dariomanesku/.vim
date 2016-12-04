.PHONY: mac linux windows update colors

default:
	@echo "Hello :) RTFM!"

mac: linux

linux:
	mkdir -p .undodir
	mkdir -p .tmp
	ln -s ~/.vim/vimrc ~/.vimrc > /dev/null 2>&1 || true
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

windows:
	mkdir -p _tmp
	mkdir -p _undodir
	curl -fLo ~/vimfiles/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s ~/vimfiles/vimrc ~/_vimrc > /dev/null 2>&1 || true
