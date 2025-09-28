function _wslwrap_find_winexe --argument-names cmd --description "Find Windows executable path using where.exe"
    if /mnt/c/WINDOWS/system32/where.exe $cmd 2>/dev/null </dev/null | read -l win_path
        set win_path (string trim -- $win_path)
        if set -l wsl_path (wslpath -a $win_path 2>/dev/null)
            echo $wsl_path
            return 0
        end
    end

    return 1
end
