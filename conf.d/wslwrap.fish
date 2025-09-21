function _wslwrap_install --on-event wslwrap_install --description "Install wslwrap by setting up the function marker"
    # Marker used to identify functions managed by wslwrap.fish
    set --universal wslwrap_function_marker "wslwrap.fish::managed"
end
