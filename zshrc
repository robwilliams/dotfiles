export ZSH=$HOME/dotfiles/zsh
for config_file ($ZSH/**/*.zsh) source $config_file

export EDITOR=vim

# Add RVM to PATH for scripting
export PATH=$HOME/dotfiles/bin:/usr/local/bin:$PATH:$HOME/.rvm/bin 

# Ignore duplicates and share history between sessions.
setopt histignorealldups sharehistory

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
