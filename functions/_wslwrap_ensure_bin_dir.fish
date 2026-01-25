function _wslwrap_ensure_bin_dir --description "Ensure wslwrap user bin dir exists and env var is set"
    if not set -q WSLWRAP_BIN_DIR
        set -gx WSLWRAP_BIN_DIR "$HOME/.local/share/wslwrap/bin"
    end

    if not test -d $WSLWRAP_BIN_DIR
        if not mkdir -p $WSLWRAP_BIN_DIR
            _wslwrap_echo error "Failed to create bin directory at '$WSLWRAP_BIN_DIR'"
            return 1
        end
    end

    if not contains $WSLWRAP_BIN_DIR $fish_user_paths
        fish_add_path --global --prepend $WSLWRAP_BIN_DIR
    end

    return 0
end
