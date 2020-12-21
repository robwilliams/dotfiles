export ZSH=$HOME/dotfiles/zsh

export EDITOR=vim

setopt auto_name_dirs
setopt auto_cd # change dir just by typing path (no cd)
setopt cdablevarS # allows you to create project aliases i.e. frequent_project=~/projects/frequent/project.

# Allow [ or ] wherever
unsetopt nomatch

path=(
  ./bin
  "$HOME/.nodenv/shims"
  "$HOME/.rbenv/shims"
  "$HOME/.rbenv/bin"
  "$HOME/dotfiles/bin"
  /usr/local/heroku/bin
  /usr/local/share/npm/bin
  /usr/local/sbin
  /usr/local/bin
  "$HOME/bin"
  "$path[@]"
)

export PATH
typeset -U path

for config_file ($ZSH/**/*.zsh) source $config_file

rationalize-path path

# Show contents of directory after cd-ing into it
chpwd() {
  ll
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
