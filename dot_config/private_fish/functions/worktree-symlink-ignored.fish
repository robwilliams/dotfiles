function worktree-symlink-ignored
    set main_worktree $argv[1]
    set worktree_path $argv[2]

    set ignored_items (git -C $main_worktree ls-files -o -i --exclude-standard)
    set linked_paths

    for item in $ignored_items
        set top_level (string split -m 1 / $item)[1]

        if contains $top_level $linked_paths
            continue
        end

        if test -d "$main_worktree/$top_level"
            ln -sf "$main_worktree/$top_level" "$worktree_path/$top_level"
            echo "Symlinked dir: $top_level"
        else if test -f "$main_worktree/$top_level"
            ln -sf "$main_worktree/$top_level" "$worktree_path/$top_level"
            echo "Symlinked: $top_level"
        end

        set -a linked_paths $top_level
    end
end
