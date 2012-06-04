HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

# Ignore duplicates and share history between sessions.
setopt histignorealldups 
setopt sharehistory 
setopt inc_append_history

bindkey "^[[A" history-search-backward

bindkey "^[[B" history-search-forward
