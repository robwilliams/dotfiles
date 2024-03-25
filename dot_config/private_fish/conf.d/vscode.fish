string match -q "$TERM_PROGRAM" "vscode"
and . (code --locate-shell-integration-path fish)

set -gx EDITOR code
