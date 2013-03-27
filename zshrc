export ZSH=$HOME/dotfiles/zsh
for config_file ($ZSH/**/*.zsh) source $config_file

export EDITOR=vim

# Add RVM to PATH for scripting
export PATH=$HOME/dotfiles/bin:/usr/local/sbin:/usr/local/bin:$PATH:$HOME/.rvm/bin 
setopt auto_name_dirs
setopt auto_cd # change dir just by typing path (no cd)
setopt cdablevarS # allows you to create project aliases i.e. frequent_project=~/projects/frequent/project.

export RUBY_HEAP_MIN_SLOTS=800000
export RUBY_HEAP_FREE_MIN=100000
export RUBY_HEAP_SLOTS_INCREMENT=300000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=79000000

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/share/npm/bin:$PATH"

bindkey -v
bindkey -M vicmd '/' history-incremental-search-backward
