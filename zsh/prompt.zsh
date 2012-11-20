setopt auto_name_dirs
setopt prompt_subst

source $HOME/.zsh/git-prompt/zshrc.sh
PROMPT='%B%~%b $(git_super_status) 
%# '

# If we are in a ssh session show the hostname in the right prompt
#if [[ -n "${SSH_CLIENT+x}" ]]; then
  #RPROMPT='%m'
#fi
