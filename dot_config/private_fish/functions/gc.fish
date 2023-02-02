function gc --wraps='git commit --verbose' --description 'alias gc git commit --verbose'
  git commit --verbose $argv
        
end
