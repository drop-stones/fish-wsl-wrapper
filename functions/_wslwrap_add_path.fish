function _wslwrap_add_path --description "Add directories containing specified Windows commands to PATH"
    argparse a/append p/prepend -- $argv || return 1

    if test (count $argv) -lt 1
        _wslwrap_echo error "At least one command is required"
        _wslwrap_echo usage add-path
        return 1
    end

    # Determine fish_add_path options
    set -l fish_add_path_opts
    if set -q _flag_prepend
        set -a fish_add_path_opts --prepend
    else
        # Default to append
        set -a fish_add_path_opts --append --path
    end

    set -l failed_commands

    for cmd in $argv
        set -l cached_path "$wslwrap_path_prefix$cmd"

        # Use cached path if available and valid
        if set -q $cached_path && test -x $$cached_path/$cmd.exe
            fish_add_path $fish_add_path_opts $$cached_path
            continue
        end

        # Use shared where.exe resolution
        if set -l wsl_path (_wslwrap_find_winexe $cmd)
            set -l dir_path (dirname $wsl_path)
            set -U $cached_path $dir_path
            fish_add_path $fish_add_path_opts $dir_path
        else
            _wslwrap_echo warning "Command '$cmd' not found in Windows PATH"
            set -a failed_commands $cmd
        end
    end

    if test (count $failed_commands) -gt 0
        return 1
    end

    return 0
end
