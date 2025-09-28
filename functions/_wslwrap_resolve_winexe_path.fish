function _wslwrap_resolve_winexe_path --argument-names cmd cache --description "Resolve the path of a Windows command"
    set -l cache_var (_wslwrap_get_winexe_envvar $cmd)

    # Return cached path if exists and file is accessible
    if set -q $cache_var && test -x $$cache_var
        echo $$cache_var
        return 0
    end

    # Resolve path from multiple sources
    set -l resolved_path ""

    # Try PATH resolution first
    if not set resolved_path (command -v $cmd.exe 2>/dev/null)
        # Fallback to where.exe
        if /mnt/c/WINDOWS/system32/where.exe $cmd 2>/dev/null </dev/null | read -l win_path
            set win_path (string trim -- $win_path)
            if not set resolved_path (wslpath -a $win_path 2>/dev/null)
                _wslwrap_echo error "Failed to resolve Windows path for '$cmd'."
                return 1
            end
        end
    end

    # If no path found, return error
    if test -z "$resolved_path"
        _wslwrap_echo error "'$cmd' is not found in PATH or Windows PATH."
        return 1
    end

    # Cache result based on strategy
    switch $cache
        case system
            set --universal $cache_var $resolved_path
        case path
            set --global $cache_var $resolved_path
        case "*"
            _wslwrap_echo error "Unknown cache mode '$cache'. Use 'system' or 'path'."
            return 1
    end

    echo $resolved_path
    return 0
end
