export ZSH=$HOME/dotfiles/zsh
for config_file ($ZSH/**/*.zsh) source $config_file

export EDITOR=vim

setopt auto_name_dirs
setopt auto_cd # change dir just by typing path (no cd)
setopt cdablevarS # allows you to create project aliases i.e. frequent_project=~/projects/frequent/project.

# Show contents of directory after cd-ing into it
chpwd() {
  ll
}

typeset -gU path

path=(/usr/local/heroku/bin $path)
path=(/usr/local/share/npm/bin $path)
path=(/usr/local/sbin $path)
path=(/usr/local/bin $path)
path=(~/dotfiles/bin $path)

### rbenv
if [[ -d ~/.rbenv ]]; then;
  path=(~/.rbenv/bin $path)
  eval "$(rbenv init -)"
fi

path=(./bin $path) # For bundle binstubs
