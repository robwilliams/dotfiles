#!/bin/bash
for file in tmux.conf zshrc gitignore
do
  echo "Linking $file to ~/.$file..";
  ln -sf ~/dotfiles/$file ~/.$file;
done

