#!/bin/sh
cd "$HOME"
echo 'source etc/bashrc' >> .bash_profile
ln -sf etc/inputrc .inputrc
ln -sf etc/vim .vim
ln -sf etc/vimrc .vimrc
