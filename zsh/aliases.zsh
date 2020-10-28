alias reload!="source ~/.zshrc && echo 'Reloaded!'" # ZSH reload!

# GIT aliases
alias g="git status -sb"
alias gst="git status -sb"
alias gc="git commit -v"
alias gap="git add -p"
wip () {
  local msg
  msg="WIP: $*"
  git commit -m $msg
} 
alias wap="git add -p && wip"

# Directory listing aliases
alias sl="ls"
alias ks="ls"
alias l="ls"
alias ll="ls -alh"
alias la="ll"
alias tree="tree -C"

alias be="bundle exec "
alias vim="nvim"

alias ":q"="exit"

alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo 'Public key copied to clipboard.'"

typeset -gU cdpath
cdpath=(~/Projects $cdpath)
cdpath=(~/Projects/robwilliams $cdpath)
cdpath=(~/Projects/play $cdpath)

# CHMOD helpers (work just like chmod but only on files or directories)
chmoddirs () { find $2 -type d -exec chmod $1 {} \; } 
chmodfiles () { find $2 -type f -exec chmod $1 {} \; } 
