function _wslwrap_get_winexe_envvar --argument-names cmd --description "Get the environment variable name for caching the Windows executable path of a command"
    echo "wslwrap_winexe_$cmd"
end
