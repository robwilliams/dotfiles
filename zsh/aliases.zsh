alias reload!="source ~/.zshrc && echo 'Reloaded!'" # ZSH reload!

# GIT aliases
alias g="git status -sb"
alias gst="echo 'Use g!' && git status -sb"
alias gc="git commit -v"
alias gp="git push"
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
alias ":q"="exit"

alias -g sr=" script/rails "
alias -g with_tmux=" -t tmux a"
alias imac_sleep="ssh imac 'pmset sleepnow'"

alias tmx="tmux attach -t $(print -P %1~) || tmux new -s $(print -P %1~)"

typeset -gU cdpath
cdpath=(~/Projects $cdpath)
cdpath=(~/Projects/stinkyink $cdpath)
cdpath=(~/Projects/robwilliams $cdpath)
cdpath=(~/Projects/play $cdpath)

# CHMOD helpers (work just like chmod but only on files or directories)
chmoddirs () { find $2 -type d -exec chmod $1 {} \; } 
chmodfiles () { find $2 -type f -exec chmod $1 {} \; } 
