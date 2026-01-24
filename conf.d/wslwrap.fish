# Marker used to identify functions managed by wslwrap.fish
set --global wslwrap_function_marker "wslwrap.fish::managed"

# Prefix for cached Windows executable paths
set --global wslwrap_winexe_prefix _wslwrap_winexe_

function _wslwrap_uninstall --on-event wslwrap_uninstall --description "Uninstall wslwrap by unregistering all managed functions"
    # Unregister all managed functions
    wslwrap list | wslwrap unregister

    # Remove all cached wslwrap variables
    for cached_winexe in (set -n | string match "$wslwrap_winexe_prefix*")
        set -e $cached_winexe
    end

    # Remove the universal variable
    set -q wslwrap_function_marker && set -e wslwrap_function_marker
    set -q wslwrap_winexe_prefix && set -e wslwrap_winexe_prefix
end

function _wslwrap_clear_cache --on-variable PATH --description "Clear cached winexe paths when PATH changes"
    for global_var in (set -n -g | string match "$wslwrap_winexe_prefix*")
        set -e -g $global_var
    end
end
