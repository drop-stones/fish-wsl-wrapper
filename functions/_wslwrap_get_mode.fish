function _wslwrap_get_mode --argument-names func_name --description "Get the wrapper mode (auto, windows, builtin) of a wslwrap-managed function"
    _wslwrap_is_managed $func_name; or return 1

    set -l marker (_wslwrap_get_wrapper_marker)
    set -l pattern "^"(string escape --style=regex -- $marker)" (\S+) for "
    for line in (functions --details --verbose $func_name)
        set -l match (string match -r $pattern -- $line)
        if test (count $match) -ge 2
            echo $match[2]
            return 0
        end
    end
    return 1
end
