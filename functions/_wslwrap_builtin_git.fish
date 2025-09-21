function _wslwrap_builtin_git --description "builtin hook for git (tide compatibility)"
    if _wslwrap_in_windows_filesystem
        set -l winexe_path (_wslwrap_resolve_winexe_path git) || return 1
        if _wslwrap_in_stack _tide_item_git
            $winexe_path $argv </dev/null
        else
            $winexe_path $argv
        end
    else
        command git $argv
    end
end
