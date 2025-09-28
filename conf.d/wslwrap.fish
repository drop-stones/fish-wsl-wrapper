function _wslwrap_install --on-event wslwrap_install --description "Install wslwrap by setting up the function marker"
    # Marker used to identify functions managed by wslwrap.fish
    set --universal wslwrap_function_marker "wslwrap.fish::managed"

    # Prefix for cached Windows executable paths
    set --universal wslwrap_winexe_prefix _wslwrap_winexe_

    # Prefix for cached Windows path directories
    set --universal wslwrap_path_prefix _wslwrap_path_
end

function _wslwrap_uninstall --on-event wslwrap_uninstall --description "Uninstall wslwrap by unregistering all managed functions"
    # Unregister all managed functions
    wslwrap list | wslwrap unregister

    # Remove all cached wslwrap variables
    for cached_winexe in (set -n | string match "$wslwrap_winexe_prefix*")
        set -e $cached_winexe
    end
    for cached_path in (set -n | string match "$wslwrap_path_prefix*")
        set -e $cached_path
    end

    # Remove the universal variable
    set -q wslwrap_function_marker && set -e wslwrap_function_marker
    set -q wslwrap_winexe_prefix && set -e wslwrap_winexe_prefix
    set -q wslwrap_path_prefix && set -e wslwrap_path_prefix
end

function _wslwrap_clear_cache --on-variable PATH --description "Clear cached winexe paths when PATH changes"
    for global_var in (set -n -g | string match "$wslwrap_winexe_prefix*")
        set -e -g $global_var
    end
end
