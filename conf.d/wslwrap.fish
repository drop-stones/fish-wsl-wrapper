function _wslwrap_install --on-event wslwrap_install
    # Marker used to identify functions managed by wslwrap.fish
    set --universal wslwrap_function_marker "wslwrap.fish::managed"
end

function _wslwrap_uninstall --on-event wslwrap_uninstall
    # Unregister all managed functions
    wslwrap list | wslwrap unregister

    # Remove the universal variable
    set -q wslwrap_function_marker && set --erase wslwrap_function_marker
end
