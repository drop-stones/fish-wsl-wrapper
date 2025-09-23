function _wslwrap_resolve_winexe_path --argument-names cmd --description "Resolve the path of a Windows command"
    set -l cache_var (_wslwrap_get_winexe_envvar $cmd)

    if not set -q $cache_var || not test -x $$cache_var
        # Find Windows executable and convert to WSL path
        if not /mnt/c/WINDOWS/system32/where.exe $cmd | read -l win_path
            _wslwrap_echo error "'$cmd' is not found in Windows PATH."
            return 1
        end

        set win_path (string trim -- $win_path)

        if not set -l wsl_path (wslpath -a $win_path 2>/dev/null)
            _wslwrap_echo error "Failed to resolve Windows path for '$cmd'."
            return 1
        end

        set --universal $cache_var $wsl_path
    end

    echo $$cache_var
end
