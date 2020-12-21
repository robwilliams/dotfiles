setopt prompt_subst

function ssh_prompt() {
  if [ $SSH_CONNECTION ]; then echo "%M⋮"; fi
}

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
