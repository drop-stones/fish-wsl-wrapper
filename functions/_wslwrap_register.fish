function _wslwrap_register --description "Register a wrapper based on the given mode: auto or windows"
    argparse --ignore-unknown 'mode=' 'cache=' -- $argv; or return 1

    if test (count $argv) -lt 1
        _wslwrap_echo error "command is required"
        _wslwrap_echo usage register
        return 1
    end

    # Remove existing function to allow updates
    set -l cmd $argv[1]
    if functions -q $cmd
        _wslwrap_echo info "Updating existing wrapper for '$cmd'"
        wslwrap unregister $cmd
    end

    set -l mode auto
    if set -q _flag_mode
        set mode $_flag_mode[-1]
    end

    set -l cache system
    if set -q _flag_cache
        set cache $_flag_cache[-1]

        if not contains $cache system path
            _wslwrap_echo error "Unknown cache mode '$cache'. Use 'system' or 'path'."
            _wslwrap_echo usage register
            return 1
        end
    end

    switch $mode
        case auto
            _wslwrap_register_auto $cache $argv
        case windows
            _wslwrap_register_windows $cache $argv
        case "*"
            _wslwrap_echo error "Unknown mode '$mode'"
            _wslwrap_echo usage register
            return 1
    end

    return $status
end
