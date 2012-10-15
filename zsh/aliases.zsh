# If the mate command doesn't exist then use default EDITOR instead.
if (( $+commands[mate] )); then
  # it exists
else
  alias -g mate="vim"
fi

alias -g nano="vim" # Man up!

# GIT aliases
alias gst="git status"
alias gc="git commit -v"
alias gap="git add -p"
alias ssp="hack && rake && ship"

alias s="sudo "
alias sr="script/rails "

# Directory listing aliases
alias sl="ls"
alias ks="ls"
alias l="ls"
alias ll="ls -al"
alias la="ls -al"
alias tree="tree -C"
alias be="bundle exec "

alias -g with_tmux=" -t tmux a"

# Project aliases
stinkyink=~/Projects/stinkyink/stinkyink
axis=~/Projects/stinkyink/axis
steve=~/Projects/stinkyink/steve
puppet=~/Projects/stinkyink/puppet
active_press=~/Projects/robwilliams/active_press

# CHMOD helpers (work just like chmod but only on files or directories)
chmoddirs () { find $2 -type d -exec chmod $1 {} \; } 
chmodfiles () { find $2 -type f -exec chmod $1 {} \; } 
