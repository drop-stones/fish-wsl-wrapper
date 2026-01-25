function _wslwrap_register_auto --description 'Register a wrapper function for a command to auto-switch between Windows and WSL filesystems'
    set -l cmd $argv[1]
    set -l options $argv[2..-1]
    set -l marker (_wslwrap_get_wrapper_marker)

    if functions -q _wslwrap_builtin_$cmd
        function $cmd --inherit-variable cmd --inherit-variable options --description "$marker builtin for $cmd"
            _wslwrap_builtin_$cmd $options $argv
        end
    else
        function $cmd --inherit-variable cmd --inherit-variable options --description "$marker auto for $cmd"
            if _wslwrap_in_windows_filesystem (pwd)
                set -l winexe_path (_wslwrap_resolve_winexe_path $cmd) || return 1
                $winexe_path $options $argv
            else
                command $cmd $options $argv
            end
        end
    end
end
