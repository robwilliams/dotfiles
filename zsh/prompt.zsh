setopt prompt_subst

function ssh_prompt() {
  if [ $SSH_CONNECTION ]; then echo "%M⋮"; fi
}

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
