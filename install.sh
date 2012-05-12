#!/bin/bash
for file in tmux.conf zshrc gitignore_global vim gvimrc vimrc ssh/config gitconfig
do
  echo "Linking $file to ~/.$file..";
  ln -sf ~/dotfiles/$file ~/.$file;
done
