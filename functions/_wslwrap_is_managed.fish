function _wslwrap_is_managed --argument-names func_name --description "Check if function is managed by wslwrap.fish"
    functions -q $func_name || return 1

    # Check marker existence
    set -l description (functions $func_name | string match -r '^function.*--description\s+[\'"]?([^\'"]+)[\'"]?')
    string match -rq "^$wslwrap_function_marker" $description
end
