function _wslwrap_resolve_winexe_path --argument-names cmd --description "Resolve the path of a Windows command"
    set -l cache_var (_wslwrap_get_winexe_envvar $cmd)

    # Return cached path if exists and file is accessible
    if set -q $cache_var && test -x $$cache_var
        echo $$cache_var
        return 0
    end

    # Try PATH resolution (no cache - standard behavior)
    if set -l path_result (command -v $cmd.exe 2>/dev/null)
        echo $path_result
        return 0
    end

    # Fallback to where.exe and cache result
    if /mnt/c/WINDOWS/system32/where.exe $cmd 2>/dev/null </dev/null | read -l win_path
        set win_path (string trim -- $win_path)

        if set -l wsl_path (wslpath -a $win_path 2>/dev/null)
            set --universal $cache_var $wsl_path
            echo $wsl_path
            return 0
        else
            _wslwrap_echo error "Failed to resolve Windows path for '$cmd'."
            return 1
        end
    end

    _wslwrap_echo error "'$cmd' is not found in PATH or Windows PATH."
    return 1
end
