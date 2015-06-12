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
alias ll="ls -alh"
alias la="ll"
alias tree="tree -C"

alias z="zeus "
alias be="bundle exec "
alias frt="foreman run -e .env,.env.test "
alias frd="foreman run -e .env,.env.development "
alias fr=frd

alias ":q"="exit"

alias imac_sleep="ssh imac 'pmset sleepnow'"
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo 'Public key copied to clipboard.'"

typeset -gU cdpath
cdpath=(~/Projects $cdpath)
cdpath=(~/Projects/stinkyink $cdpath)
cdpath=(~/Projects/robwilliams $cdpath)
cdpath=(~/Projects/play $cdpath)

# CHMOD helpers (work just like chmod but only on files or directories)
chmoddirs () { find $2 -type d -exec chmod $1 {} \; } 
chmodfiles () { find $2 -type f -exec chmod $1 {} \; } 
