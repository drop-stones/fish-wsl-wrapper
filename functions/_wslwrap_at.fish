# Success (status 0) if the nth token exactly matches any of the expected words.
# Usage: _wslwrap_at <position> <word> [<word> ...]
function _wslwrap_at --description "Check if token at position matches any expected words"
    test (count $argv) -ge 2; or return 1
    set -l pos $argv[1]
    set -e argv[1]
    set -l toks (commandline -opc)
    test (count $toks) -ge $pos; or return 1
    set -l token $toks[$pos]
    for w in $argv
        if test "$token" = "$w"
            return 0
        end
    end
    return 1
end
