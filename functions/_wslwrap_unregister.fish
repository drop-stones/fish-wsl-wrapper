function _wslwrap_unregister --description "Unregister managed wrapper functions"
    # If stdin is a pipe (not a TTY), append lines to argv.
    if not isatty stdin
        read --local --null --list stdin
        set --append argv $stdin

        # Early return if no commands were read from stdin
        if test (count $argv) -eq 0
            return 0
        end
    end

    if test (count $argv) -eq 0
        _wslwrap_echo error "command is required"
        _wslwrap_echo usage unregister
        return 1
    end

    for cmd in $argv
        if _wslwrap_is_managed $cmd
            set -l winexe_path (_wslwrap_get_winexe_cache_varname $cmd)
            set -q $winexe_path && set --erase $winexe_path
            functions -e $cmd
        else
            _wslwrap_echo error "'$cmd' is not managed or not found"
            _wslwrap_echo usage unregister
            return 1
        end
    end
end
