# _wsl_wrapper_help.fish
# Print help message for wsl_wrapper_register function.
# This is intended for end users to understand how to use the plugin.
function _wsl_wrapper_help --description "Show usage information for wsl_wrapper_register"
    echo "Usage: wsl_wrapper_register [OPTIONS] <command>"
    echo
    echo "Register a wrapper function for a given command."
    echo "When your current working directory is under /mnt/, the Windows executable"
    echo "('<command>.exe') will be invoked instead of the WSL one."
    echo
    echo "Options:"
    echo "  --win_extra=ARGS   Extra arguments always passed to the Windows command"
    echo "  --wsl_extra=ARGS   Extra arguments always passed to the WSL command"
    echo "  -h, --help         Show this help message"
    echo
    echo "Examples:"
    echo "  wsl_wrapper_register git"
    echo "  wsl_wrapper_register fd --win_extra='--path-separator /'"
end
