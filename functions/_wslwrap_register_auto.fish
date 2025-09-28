function _wslwrap_register_auto --description 'Register a wrapper function for a command to auto-switch between Windows and WSL filesystems'
    set -l cache $argv[1]
    set -l cmd $argv[2]
    set -l options $argv[3..-1]
    if functions -q _wslwrap_builtin_$cmd
        function $cmd --inherit-variable cache --inherit-variable cmd --inherit-variable options --description "$wslwrap_function_marker: builtin for $cmd"
            _wslwrap_builtin_$cmd $cache $options $argv
        end
    else
        function $cmd --inherit-variable cache --inherit-variable cmd --inherit-variable options --description "$wslwrap_function_marker: auto for $cmd"
            if _wslwrap_in_windows_filesystem
                set -l winexe_path (_wslwrap_resolve_winexe_path $cmd $cache) || return 1
                $winexe_path $options $argv
            else
                command $cmd $options $argv
            end
        end
    end
end
