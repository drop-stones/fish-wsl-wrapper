function _wslwrap_resolve_winexe_path --argument-names cmd --description "Resolve the path of a Windows command"
    set -l cached_winexe (_wslwrap_get_winexe_cache_varname $cmd)

    # Return cached path if exists and file is accessible
    if set -q $cached_winexe && test -x $$cached_winexe
        echo $$cached_winexe
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
    set --global --export $cached_winexe $resolved_path

    echo $resolved_path
    return 0
end
