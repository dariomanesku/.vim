mac: linux

linux:
	ln -s ~/.vim/vimrc ~/.vimrc	> /dev/null 2>&1 || true
	cd ~/.vim
	git submodule init
	git submodule update

windows:
	ln -s ~/vimfiles/vimrc ~/_vimrc	> /dev/null 2>&1 || true
	ln -s ~/vimfiles/vimrc ~/.vimrc	> /dev/null 2>&1 || true
	ln -s ~/vimfiles ~/.vim > /dev/null 2>&1 || true
	cd ~/vimfiles
	git submodule init
	git submodule update

update:
	git submodule foreach git pull origin master
