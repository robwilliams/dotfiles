function ytb
    if test (count $argv) -eq 0 -o "$argv[1]" = "help"
        echo "Available ytb commands:"
        for fn in (functions -n | string match 'ytb-*')
            echo ""
            echo "▶" (string replace 'ytb-' '' $fn)
            if functions -q $fn
                $fn --help ^ /dev/null
            end
        end
        return 0
    end

    set cmd ytb-$argv[1]
    if functions -q $cmd
        $cmd $argv[2..-1]
    else
        echo "Unknown command: $argv[1]"
        echo "Run 'ytb help' to list available commands."
        return 1
    end
end
