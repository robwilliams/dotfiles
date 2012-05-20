#!/bin/bash
for file in tmux.conf zsh zshrc gitignore_global vim gvimrc vimrc ssh/config gitconfig gemrc irbrc ackrc
do
  echo "Linking $file to ~/.$file..";
  rm ~/.$file;
  ln -sf ~/dotfiles/$file ~/.$file;
done
