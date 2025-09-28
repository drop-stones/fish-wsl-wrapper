function _wslwrap_link --description "Create symlink for Windows executable"
    if test (count $argv) -lt 1
        _wslwrap_echo error "command is required"
        _wslwrap_echo usage link
        return 1
    end

    set -l cmd $argv[1]
    set -l target_path $argv[2] # Optional target path
    set -l symlink_path /usr/local/bin/$cmd

    # Check if symlink already exists
    if test -L $symlink_path
        # Check if it points to a Windows executable
        set -l target (readlink $symlink_path)
        if _wslwrap_in_windows_filesystem $target
            return 0
        else
            _wslwrap_echo error "Symlink for '$cmd' already exists and does not point to a Windows executable"
            return 1
        end
    end

    # Get Windows executable path
    set -l exe_path
    if test -n "$target_path"
        # User specified target path
        if not _wslwrap_in_windows_filesystem $target_path
            _wslwrap_echo error "Specified target path '$target_path' is not a valid Windows executable path"
            return 1
        end
        set exe_path $target_path
    else if not set exe_path (_wslwrap_find_winexe $cmd)
        _wslwrap_echo error "Windows executable for '$cmd' not found"
        return 1
    end

    # Create symlink with sudo
    if not sudo ln -s $exe_path $symlink_path 2>/dev/null
        _wslwrap_echo error "Failed to create symlink for '$cmd'"
        return 1
    end

    return 0
end
