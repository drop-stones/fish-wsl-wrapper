# Print candidates from items excluding already-used tokens from index N.
# - N: 1-based index where user-provided items start (e.g., 3 for "wslwrap <subcommand> <here>").
function _wslwrap_unused_from --argument-names N
    # All tokens left of the cursor, including "wslwrap <subcommand>"
    set -f tokens (commandline -xpc)

    # Require at least N tokens (so that the delegated command exists at position N)
    if test -z $N
        return
    end

    set -f used $tokens[$N..-1]
    set -f items $argv[2..-1]

    for line in $items
        # Compare by the first field before a TAB (name), keep original line for output
        set -f name (string split -m1 \t -- $line)[1]
        if contains -- $name $used
            continue
        end
        echo $line
    end
end
