function worktree-add
    # Usage: worktree-add <new-branch-name> [worktree-path]
    if test (count $argv) -eq 0
        echo "Usage: worktree-add <new-branch-name> [worktree-path]"
        echo "  Creates a new git worktree with symlinked shared files"
        echo ""
        echo "Examples:"
        echo "  wta feature-name          # creates worktree at ../feature-name"
        echo "  wta feature-name /path    # creates worktree at custom path"
        return 1
    end

    set branch_name $argv[1]
    set worktree_path $argv[2]

    # Default to ../branch-name if no path specified
    if test -z "$worktree_path"
        set worktree_path "../$branch_name"
    end

    # Create the worktree
    git worktree add -b $branch_name $worktree_path

    if test $status -eq 0
        # Get the main worktree path
        set main_worktree (git worktree list | head -n 1 | awk '{print $1}')

        # Symlink all git-ignored files and directories
        worktree-symlink-ignored $main_worktree $worktree_path

        # CD into the new worktree
        cd $worktree_path
    end
end
