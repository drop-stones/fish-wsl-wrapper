function _wslwrap_get_winexe_cache_varname --argument-names cmd --description "Get the cache variable name for a given Windows command"
    echo (_wslwrap_get_winexe_prefix)$cmd
end
