function _wslwrap_unlink --description "Remove Windows executable symlinks"
    # If stdin is a pipe (not a TTY), append lines to argv.
    if not isatty stdin
        read --local --null --list stdin
        set --append argv $stdin
    end

    if test (count $argv) -lt 1
        _wslwrap_echo error "command is required"
        _wslwrap_echo usage unlink
        return 1
    end

    set -l has_error 0

    for cmd in $argv
        set -l symlink_path $WSLWRAP_BIN_DIR/$cmd

        # Check if symlink exists
        if not test -L $symlink_path
            _wslwrap_echo error "Symlink for '$cmd' does not exist"
            set has_error 1
            continue
        end

        # Check if symlink points to a Windows executable
        set -l target (readlink $symlink_path)
        if not _wslwrap_in_windows_filesystem $target
            _wslwrap_echo error "Symlink for '$cmd' does not point to a Windows executable"
            set has_error 1
            continue
        end

        # Remove symlink with sudo
        if not sudo rm $symlink_path 2>/dev/null
            _wslwrap_echo error "Failed to remove symlink for '$cmd'"
            set has_error 1
            continue
        end
    end

    return $has_error
end
