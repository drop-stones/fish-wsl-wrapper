function _wslwrap_resolve_managed_path --argument-names cmd --description "Resolve the path a wslwrap wrapper would invoke at the current directory"
    set -l mode (_wslwrap_get_mode $cmd); or return 1

    switch $mode
        case windows
            _wslwrap_resolve_winexe_path $cmd
        case auto builtin
            if _wslwrap_in_windows_filesystem (pwd)
                _wslwrap_resolve_winexe_path $cmd
            else
                command which $cmd 2>/dev/null
            end
        case '*'
            return 1
    end
end
