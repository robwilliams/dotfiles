autoload -U colors && colors
autoload -U compinit
compinit


zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/tmp/zsh/cache
zstyle ':completion:*:functions' ignored-patterns '_*' # Ignores commands that are not installed.
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' insert-tab pending
setopt completealiases
