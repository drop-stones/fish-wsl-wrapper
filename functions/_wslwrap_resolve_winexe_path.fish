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
    if set resolved_path (command -v $cmd.exe 2>/dev/null)
    else if set resolved_path (_wslwrap_find_winexe $cmd)
    else
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
