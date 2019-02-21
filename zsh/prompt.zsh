setopt prompt_subst

function ssh_prompt() {
  if [ $SSH_CONNECTION ]; then echo "%M⋮"; fi
}

GIT_PROMPT_EXECUTABLE="haskell"
source $HOME/.zsh/zsh-git-prompt/zshrc.sh
PROMPT='$(ssh_prompt)%B%~%b $(git_super_status) 
%(!.%{$fg[red]%}.)❯ %{${reset_color}%'
