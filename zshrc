export ZSH=$HOME/dotfiles/zsh
for config_file ($ZSH/**/*.zsh) source $config_file

export EDITOR=vim

setopt auto_name_dirs
setopt auto_cd # change dir just by typing path (no cd)
setopt cdablevarS # allows you to create project aliases i.e. frequent_project=~/projects/frequent/project.

if [ -f /etc/profile ]; then;
  PATH=""
  source /etc/profile
fi

PATH=/usr/local/heroku/bin:$PATH
PATH=/usr/local/share/npm/bin:$PATH
PATH=/usr/local/sbin:$PATH
PATH=/usr/local/bin:$PATH
PATH=~/dotfiles/bin:$PATH

### rbenv
if [[ -d ~/.rbenv ]]; then;
  PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

PATH=./bin:$PATH # For bundle binstubs

export PATH
