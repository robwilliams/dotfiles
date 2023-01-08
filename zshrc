# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
  /opt/homebrew/sbin
  /opt/homebrew/bin
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"
