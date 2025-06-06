function grim --wraps='git rebase -i main' --description 'alias grim git rebase -i main'
  git rebase -i main $argv
        
end
