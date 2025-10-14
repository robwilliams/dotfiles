function worktree-remove
    if test (count $argv) -eq 0
        echo "Usage: worktree-remove <worktree-path>"
        echo "  Removes a git worktree (only if working directory is clean)"
        echo ""
        echo "Examples:"
        echo "  wtrm .                 # remove current worktree"
        echo "  wtrm ../feature-name   # remove specific worktree"
        return 1
    end

    set worktree_path $argv[1]

    # If '.' resolve to current worktree directory
    if test "$worktree_path" = "."
        set worktree_path (pwd)
    end

    # Check if working directory is clean
    if test -n "(git status --porcelain)"
        echo "Error: Working directory is not clean"
        echo "Please commit or stash your changes first"
        return 1
    end

    # Get main worktree path
    set main_worktree (git worktree list | head -n 1 | awk '{print $1}')

    # If we're currently in the worktree to be removed, cd to main first
    if test (pwd) = (realpath $worktree_path)
        echo "Switching to main worktree..."
        cd $main_worktree
    end

    # Remove the worktree
    git worktree remove $worktree_path
end
