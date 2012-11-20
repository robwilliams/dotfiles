setopt prompt_subst

source $HOME/.zsh/git-prompt/zshrc.sh
PROMPT='%B%~%b $(git_super_status) 
%# '
