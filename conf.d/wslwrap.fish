function _wslwrap_uninstall --on-event wslwrap_uninstall --description "Uninstall wslwrap by unregistering all managed functions"
    # Unregister all managed functions
    wslwrap list | wslwrap unregister

    # Remove all cached wslwrap variables
    _wslwrap_clear_winexe_cache
end

function _wslwrap_clear_cache --on-variable PATH --description "Clear cached winexe paths when PATH changes"
    # Remove all cached wslwrap variables
    _wslwrap_clear_winexe_cache
end
