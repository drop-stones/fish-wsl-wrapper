# _wslwrap_echo_internal: Print message with optional color, only if output is a TTY
# Options:
#   -c/--color   : color arguments for set_color
#   -e/--echo    : echo options
#   -o/--output  : output stream (stdout/stderr)
# Arguments:
#   message      : message to print
function _wslwrap_echo_internal --description "Print message with optional color, only if stdout is a TTY (internal use)"
    set -l color_opts
    set -l echo_opts
    set -l output stdout
    set -l message

    argparse "c/color=" "e/echo=" "o/output=" -- $argv; or return 1
    set message $argv

    if set -q _flag_color
        set color_opts (string split " " $_flag_color)
    end

    if set -q _flag_echo
        set echo_opts (string split " " -- $_flag_echo)
    end

    if set -q _flag_output
        set output $_flag_output
    end

    set -l out_fd 1
    if test $output = stderr
        set out_fd 2
    end

    if isatty $out_fd
        if test (count $color_opts) -gt 0
            set_color $color_opts
        end
        echo $echo_opts $message >&$out_fd
        set_color normal
    else
        echo $echo_opts $message >&$out_fd
    end
end
