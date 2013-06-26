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

path=(
  ./bin
  "$HOME/.rbenv/shims"
  "$HOME/.rbenv/bin"
  "$HOME/dotfiles/bin"
  /usr/local/heroku/bin
  /usr/local/share/npm/bin
  /usr/local/sbin
  /usr/local/bin
  /usr/local/bin/bullshit
  "$HOME/bin"
  "$path[@]"
)

export PATH
typeset -U path

rationalize-path path
