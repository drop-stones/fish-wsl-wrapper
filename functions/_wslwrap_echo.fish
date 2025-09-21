# _wslwrap_echo: Internal function for preset color output
# Arguments:
#   $preset - output style (header, command, error, etc.)
#   $rest   - messages to print
function _wslwrap_echo --description "Print with preset colors"
    argparse n -- $argv; or return 1

    set -l preset $argv[1]
    set -l rest $argv[2..-1]
    set -l echo_opt

    if set -q _flag_n
        set echo_opt -e -n
    end

    switch $preset
        case header
            _wslwrap_echo_internal $echo_opt -c "blue --bold" $rest
        case command
            _wslwrap_echo_internal $echo_opt -c green $rest
        case error
            printf "\e[1;31merror\e[0m" >&2 # always print red "error"
            echo -n ": " >&2
            for message in $rest
                echo $echo_opt $message >&2
            end
        case warning
            printf "\e[1;33mwarning\e[0m" # always print yellow "warning"
            echo -n ": "
            for message in $rest
                echo $echo_opt $message
            end
        case info
            _wslwrap_echo_internal -e -n -c cyan INFO
            echo -n ": "
            for message in $rest
                echo $echo_opt $message
            end
        case usage
            echo -n "Try '"
            _wslwrap_echo command -n (string join ' ' "wslwrap help" $rest)
            echo "' for usage."
        case '*'
            _wslwrap_echo_internal $echo_opt $rest
    end
end
