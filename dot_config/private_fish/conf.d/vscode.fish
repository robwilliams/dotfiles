string match -q "$TERM_PROGRAM" "vscode"
and . (code --locate-shell-integration-path fish)

set -gx EDITOR code

# Auto-attach to persistent tmux session in VSCode
if string match -q "$TERM_PROGRAM" "vscode"
    and not set -q TMUX
    and status is-interactive
    tmux-project-session
end
