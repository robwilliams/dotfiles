if test "$TERM_PROGRAM" = "vscode"
    and type -q code
    . (code --locate-shell-integration-path fish)
    set -gx EDITOR "code --wait"
else
    set -gx EDITOR nvim
end
