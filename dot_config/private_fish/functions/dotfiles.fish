function dotfiles --wraps='chezmoi edit' --description 'alias dotfiles chezmoi edit'
  chezmoi edit $argv
        
end
