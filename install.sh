#!/bin/bash
for file in tmux.conf zsh zshrc gitignore_global vim gvimrc vimrc ssh/config gitconfig
do
  echo "Linking $file to ~/.$file..";
  rm ~/.$file;
  ln -sf ~/dotfiles/$file ~/.$file;
done
