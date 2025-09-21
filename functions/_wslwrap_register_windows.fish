function _wslwrap_register_windows --description 'Register a wrapper function for a command to run in Windows environment'
    set -l cmd $argv[1]
    set -l options $argv[2..-1]
    function $cmd --inherit-variable cmd --inherit-variable options --description "$wslwrap_function_marker: windows for $cmd"
        set -l winexe_path (_wslwrap_resolve_winexe_path $cmd) || return 1
        $winexe_path $options $argv
    end
end
