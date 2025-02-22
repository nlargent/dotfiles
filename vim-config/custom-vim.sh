
#!/bin/bash

# the flag -f is used to match the file name, the flag -s is to make sure the file is not empty
if [ -f ~/.vimrc ] && [ -s ~/.vimrc ]; then
	echo ".vimrc found and not zero"
else
	echo "Installing file"
	cp ./.vimrc ~/
fi

if [ -d ~/.vim/bundle/Vundle.vim ]; then
	echo "Vundle found"
else
	echo "Installing Vundle"
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# -n is for non-interactive
vim -n +PluginInstall +qall
