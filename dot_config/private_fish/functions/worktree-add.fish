function worktree-add
    # Usage: worktree-add <new-branch-name> [worktree-path]
    if test (count $argv) -eq 0
        echo "Usage: worktree-add <new-branch-name> [worktree-path]"
        echo "  Creates a new git worktree with symlinked shared files"
        echo ""
        echo "Examples:"
        echo "  wa feature-name          # creates worktree at ../feature-name"
        echo "  wa feature-name /path    # creates worktree at custom path"
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

        # Files to symlink
        set shared_files .mise.local.toml
        # Add more files here as needed

        # Create symlinks
        for file in $shared_files
            if test -f "$main_worktree/$file"
                ln -sf "$main_worktree/$file" "$worktree_path/$file"
                echo "Symlinked $file"
            end
        end

        # CD into the new worktree
        cd $worktree_path
    end
end
