function _wslwrap_get_command_index --description "Get command index in arguments, return 0 if no command found"
    set -l tokens (commandline -xpc)
    set -l expecting_value ""

    # If we have fewer than 3 tokens, command will be at position 3
    if test (count $tokens) -lt 3
        echo 0 # No command yet
        return 1
    end

    for i in (seq 3 (count $tokens))
        set -l token $tokens[$i]

        if test -n "$expecting_value"
            # This token is an option value, not a command
            set expecting_value ""
        else if string match -q -- '--*=*' $token
            # --option=value format, no expecting value
        else if string match -q -- '--*' $token
            # --option format, next token will be value
            set expecting_value $token
        else
            # This is the command
            echo $i
            return 0
        end
    end

    echo 0
    return 1
end
