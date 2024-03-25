set -x LANG en_GB.UTF-8

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

fish_add_path $HOME/.local/bin
