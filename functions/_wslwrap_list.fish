function _wslwrap_list --description "List all registered wrapper command names"
    for fn in (functions -n)
        if _wslwrap_is_managed $fn
            echo $fn
        end
    end
end
