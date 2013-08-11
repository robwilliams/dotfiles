setopt prompt_subst

function ssh_prompt() {
  if [ $SSH_CONNECTION ]; then echo "%{$fg_bold[white]%}%M⋮"; fi
}

source $HOME/.zsh/git-prompt/zshrc.sh
PROMPT='$(ssh_prompt)%B%~%b $(git_super_status) 
%#❯ '
