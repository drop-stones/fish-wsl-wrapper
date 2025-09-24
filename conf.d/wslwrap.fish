function _wslwrap_install --on-event wslwrap_install --description "Install wslwrap by setting up the function marker"
    # Marker used to identify functions managed by wslwrap.fish
    set --universal wslwrap_function_marker "wslwrap.fish::managed"
end

function _wslwrap_uninstall --on-event wslwrap_uninstall --description "Uninstall wslwrap by unregistering all managed functions"
    # Unregister all managed functions
    wslwrap list | wslwrap unregister

    # Remove the universal variable
    set -q wslwrap_function_marker && set --erase wslwrap_function_marker
end
