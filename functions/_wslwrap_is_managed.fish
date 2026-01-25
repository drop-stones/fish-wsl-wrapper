function _wslwrap_is_managed --argument-names func_name --description "Check if function is managed by wslwrap.fish"
    functions -q $func_name || return 1

    # Check marker existence
    set -l marker (_wslwrap_get_wrapper_marker)
    set -l description (functions $func_name | string match -r '^function.*--description\s+[\'"]?([^\'"]+)[\'"]?')
    string match -q "$marker*" $description
end
