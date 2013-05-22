setopt prompt_subst

source $HOME/.zsh/git-prompt/zshrc.sh
PROMPT='%m:%B%~%b $(git_super_status) 
%# '
