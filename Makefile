mac: linux

linux:
	ln -s ~/.vim/vimrc ~/.vimrc	> /dev/null 2>&1 || true
	cd ~/.vim
	git submodule init
	git submodule update

windows:
	@echo TODO...

update:
	git submodule foreach git pull origin master
