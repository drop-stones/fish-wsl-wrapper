function _wslwrap_builtin_rg --description "builtin hook for rg (pipe/redirect support)"
    if _wslwrap_in_windows_filesystem && isatty stdout
        set -l winexe_path (_wslwrap_resolve_winexe_path rg) || return 1
        $winexe_path $argv
    else
        command rg $argv
    end
end
