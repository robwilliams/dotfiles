function grm --wraps='git fetch origin && git rebase origin/main' --description 'alias grm git fetch origin && git rebase origin/main'
  git fetch origin && git rebase origin/main $argv
        
end
