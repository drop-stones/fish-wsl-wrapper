function _wslwrap_clear_winexe_cache --description "Clear all cached winexe paths"
    set -l prefix (_wslwrap_get_winexe_prefix)
    for winexe_cache in (set -n | string match "$prefix*")
        set -e $winexe_cache
    end
end
