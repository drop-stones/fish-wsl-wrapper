function _wslwrap_links --description "List Windows exe symlinks in WSLWRAP_BIN_DIR"
    if not set -q WSLWRAP_BIN_DIR || not test -d "$WSLWRAP_BIN_DIR"
        return
    end

    for file in $WSLWRAP_BIN_DIR/*
        if test -L $file
            set -l target (readlink $file)
            if _wslwrap_in_windows_filesystem $target
                basename "$file"
            end
        end
    end
end
