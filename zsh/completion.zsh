autoload -U colors && colors
autoload -U compinit
compinit


zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select


# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/tmp/zsh/cache

zstyle ':completion:*:functions' ignored-patterns '_*' # Ignores commands that are not installed.

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*' insert-tab pending

setopt completealiases
