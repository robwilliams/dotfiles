# ~/.config/fish/completions/ytb.fish

# Function to extract available ytb-* functions as subcommands
function __ytb_subcommands
    for fn in (functions -n | string match 'ytb-*')
        set name (string replace 'ytb-' '' $fn)
        set desc ($fn --help 2>/dev/null | head -n 1)
        printf "%s\t%s\n" $name $desc
    end
end

# Disable file completion fallback
complete -c ytb -f

# Add subcommand completions
complete -c ytb -n "not __fish_seen_subcommand_from (__ytb_subcommands | cut -f1)" -a "(__ytb_subcommands)"
