alias reload!="source ~/.zshrc && echo 'Reloaded!'" # ZSH reload!

# GIT aliases
alias gst="git status -sb"
alias gc="git commit -v"
alias gap="git add -p"


# Directory listing aliases
alias sl="ls"
alias ks="ls"
alias l="ls"
alias ll="ls -al"
alias la="ls -al"
alias tree="tree -C"
alias be="bundle exec "
alias fr="bundle exec foreman run -e app_env"

alias -g sr=" script/rails "
alias -g with_tmux=" -t tmux a"
alias imac_sleep="ssh imac 'pmset sleepnow'"

# Project aliases
stinkyink=~/Projects/stinkyink/stinkyink
axis=~/Projects/stinkyink/axis
steve=~/Projects/stinkyink/steve
puppet=~/Projects/stinkyink/puppet
dotfiles=~/dotfiles
projects=~/Projects

# CHMOD helpers (work just like chmod but only on files or directories)
chmoddirs () { find $2 -type d -exec chmod $1 {} \; } 
chmodfiles () { find $2 -type f -exec chmod $1 {} \; } 
