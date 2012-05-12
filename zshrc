autoload -U colors && colors
autoload -U compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select

setopt completealiases

# This will set the default prompt to the walters theme
prompt walters

export EDITOR=vim

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

# This loads RVM into a shell session but only if it is installed.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.

# Speed ruby up at the expense of memory 
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
