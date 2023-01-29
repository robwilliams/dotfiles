function gap --wraps='git add -p' --wraps='git add -N . && git add -p' --description 'alias gap git add -N . && git add -p'
  git add -N . && git add -p $argv
        
end
