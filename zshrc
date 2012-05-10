autoload -U colors && colors
autoload -U compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select

setopt completealiases

 
# This will set the default prompt to the walters theme
prompt walters

