function tmux-project-session --description "Persistent tmux sessions per project"
    # Derive session name from project directory
    set -l project_name (basename $PWD | string replace -a '.' '-')
    set -l session_name "proj-$project_name"

    # Parse commands
    if test (count $argv) -gt 0
        switch $argv[1]
            case list
                echo "Project sessions:"
                tmux list-sessions 2>/dev/null | grep "^proj-" || echo "  (none)"
                return
            case kill
                if tmux has-session -t $session_name 2>/dev/null
                    tmux kill-session -t $session_name
                    echo "Killed session '$session_name'"
                else
                    echo "No session '$session_name' to kill"
                end
                return
            case kill-all
                set -l sessions (tmux list-sessions -F "#{session_name}" 2>/dev/null | grep "^proj-")
                if test (count $sessions) -eq 0
                    echo "No project sessions to kill"
                    return
                end
                for s in $sessions
                    tmux kill-session -t $s
                    echo "Killed session '$s'"
                end
                return
            case help
                echo "Usage: tmux-project-session [command]"
                echo ""
                echo "Commands:"
                echo "  (none)    - Attach to or create session for current project"
                echo "  list      - List all project sessions"
                echo "  kill      - Kill session for current project"
                echo "  kill-all  - Kill all project sessions"
                echo "  help      - Show this help message"
                echo ""
                echo "Session naming: proj-<project-basename>"
                echo "Current: $session_name"
                return
        end
    end

    # Default: attach or create session
    if tmux has-session -t $session_name 2>/dev/null
        exec tmux attach-session -t $session_name
    else
        exec tmux new-session -s $session_name
    end
end
