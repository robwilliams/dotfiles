if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim

set -g fish_greeting

fish_add_path $HOME/.local/bin
