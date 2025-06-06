function grbm
    set unique_id (echo (date +%s) | md5sum | cut -d ' ' -f 1)
    set stash_name "grbm-$unique_id"

    # Fetch main branch
    git fetch origin main

    # Stash changes
    git stash push -u -m $stash_name

    # Check if that stash actually exists
    if git stash list | grep -q $stash_name
        # If the stash exists, rebase and pop it
        git rebase origin/main
        git stash pop $stash_name
    else
        # If no stash was created, just rebase
        git rebase origin/main
    end
end