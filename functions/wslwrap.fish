function wslwrap --description "Main entry point for wslwrap: manage registration, unregister, and listing of wrapper functions"
    # WSL2 check
    if not set -q WSL_DISTRO_NAME
        _wslwrap_echo warning "must be run inside WSL2"
        return 1
    end

    argparse --ignore-unknown h/help -- $argv; or return 1

    if set -ql _flag_help
        set --prepend argv help
    end

    if test (count $argv) -eq 0
        _wslwrap_echo error "subcommand required"
        _wslwrap_echo usage
        return 1
    end

    set -l subcommand $argv[1]
    set -e argv[1]

    switch $subcommand
        case register
            _wslwrap_register $argv
        case unregister
            _wslwrap_unregister $argv
        case list
            _wslwrap_list $argv
        case link
            _wslwrap_link $argv
        case unlink
            _wslwrap_unlink $argv
        case help
            _wslwrap_help $argv
        case "*"
            _wslwrap_echo error "unkown subcommand '$subcommand'"
            _wslwrap_echo usage
            return 1
    end

    return $status
end
