function _wslwrap_install --on-event wslwrap_install
    # Marker used to identify functions managed by wslwrap.fish
    set --universal wslwrap_function_marker "wslwrap.fish::managed"
end
