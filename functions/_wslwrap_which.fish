function _wslwrap_which --description "Resolve a command, considering wslwrap wrappers, with fallback to which"
    argparse --ignore-unknown a/all -- $argv; or return 1

    set -l show_all 0
    set -q _flag_all; and set show_all 1

    # Separate positional args from remaining flags (passed through to which)
    set -l positional
    set -l passthrough_flags
    for arg in $argv
        if string match -q -- '-*' $arg
            set -a passthrough_flags $arg
        else
            set -a positional $arg
        end
    end

    # No positional args → delegate entirely to which
    if test (count $positional) -eq 0
        if test $show_all -eq 1
            command which -a $passthrough_flags
        else
            command which $passthrough_flags
        end
        return $status
    end

    set -l overall_status 0

    for cmd in $positional
        set -l wslwrap_path
        if _wslwrap_is_managed $cmd
            set wslwrap_path (_wslwrap_resolve_managed_path $cmd 2>/dev/null)
        end

        if test $show_all -eq 1
            set -l results
            test -n "$wslwrap_path"; and set -a results $wslwrap_path
            for p in (command which -a $passthrough_flags $cmd 2>/dev/null)
                contains -- $p $results; or set -a results $p
            end

            if test (count $results) -eq 0
                set overall_status 1
            else
                for r in $results
                    echo $r
                end
            end
        else
            if test -n "$wslwrap_path"
                echo $wslwrap_path
            else
                command which $passthrough_flags $cmd
                or set overall_status $status
            end
        end
    end

    return $overall_status
end
