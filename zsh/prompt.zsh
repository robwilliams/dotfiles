setopt prompt_subst

function ssh_prompt() {
  if [ $SSH_CONNECTION ]; then echo "%M⋮"; fi
}

eval "$(starship init zsh)"
