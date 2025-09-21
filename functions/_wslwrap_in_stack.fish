function _wslwrap_in_stack --argument-names target --description "Check if the target function is present in the current stack trace"
    for line in (status stack-trace)
        if string match -rq "in function '$target'" -- $line
            return 0
        end
    end
    return 1
end
