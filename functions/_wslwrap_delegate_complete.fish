# Delegate completion to selected tool
# - N: 1-based token index at which the "delegated" command begins. (e.g., 3 for "wslwrap <subcommand> <here>")
function _wslwrap_delegate_complete --argument-names N --description 'Delegate completion to selected tool'
    # All tokens left of the cursor, including "wslwrap <subcommand>"
    set -f tokens (commandline -xpc)

    # The current token being completed (partial text) or empty if cursor is after whitespace
    set -f current (commandline -ct)

    # Require at least N tokens (so that the delegated command exists at position N)
    if test -z $N; or test (count $tokens) -lt $N
        return
    end

    # Build the line: "<tool> [args ...] <current>"
    # Note: appending an empty $current intentionally yields a trailing space,
    #       prompting fish to complete a new argument.
    set -f comp_string (string join ' ' -- $tokens[$N..-1] $current)

    # Ask fish to produce completions as if the user had typed that line
    complete --do-complete $comp_string
end
