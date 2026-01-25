function _wslwrap_clear --description "Clear all registered wrappers and remove WSLWRAP_BIN_DIR"
    # Remove all cached winexe paths
    _wslwrap_clear_winexe_cache

    # Remove all registered wrappers
    wslwrap list | wslwrap unregister

    # Early return if WSLWRAP_BIN_DIR does not exist
    if not set -q WSLWRAP_BIN_DIR || not test -d "$WSLWRAP_BIN_DIR"
        return 0
    end

    # Remove all symlinks in WSLWRAP_BIN_DIR
    wslwrap links | wslwrap unlink

    # Remove WSLWRAP_BIN_DIR itself
    if test "$WSLWRAP_BIN_DIR" = "$HOME/.local/share/wslwrap/bin"
        command rmdir --ignore-fail-on-non-empty "$HOME/.local/share/wslwrap/bin"
        command rmdir --ignore-fail-on-non-empty "$HOME/.local/share/wslwrap"
    end
end
