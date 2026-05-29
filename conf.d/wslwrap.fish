# return if not interactive
status is-interactive || return

# WSL2 check
if not set -q WSL_DISTRO_NAME
    _wslwrap_echo warning "must be run inside WSL2"
    return 1
end

# Ensure wslwrap user bin dir exists and env var is set
_wslwrap_ensure_bin_dir

# Initialize normalized WSLWRAP_PATH
_wslwrap_normalize_path

function _wslwrap_uninstall --on-event wslwrap_uninstall --description "Uninstall wslwrap by unregistering all managed functions"
    # Unregister all managed functions
    wslwrap list | wslwrap unregister

    # Remove all cached wslwrap variables
    _wslwrap_clear_winexe_cache
end

function _wslwrap_clear_cache --on-variable WSLWRAP_PATH --description "Re-normalize and clear cached winexe paths when WSLWRAP_PATH changes"
    _wslwrap_normalize_path
    _wslwrap_clear_winexe_cache
end
