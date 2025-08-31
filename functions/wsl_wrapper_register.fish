# wsl_wrapper_register.fish
# Register a wrapper for a command that switches between WSL and Windows executables
# based on the current working directory (/mnt/ vs. WSL filesystem).
function wsl_wrapper_register --description "Register a wrapper to switch between WSL and Windows executables"
    set -f options_spec h/help 'win_extra=?' 'wsl_extra=?'
    argparse $options_spec -- $argv; or return 1

    if set -ql _flag_help
        _wsl_wrapper_help
        return 0
    end

    if test (count $argv) -eq 0
        echo "Error: Missing required command argument."
        return 1
    else if test (count $argv) -gt 1
        echo "Error: Multiple arguments provided. Only one command is allowed."
        return 1
    end

    set -f cmd $argv[1]
    set -f win_extra $_flag_win_extra[-1]
    set -f wsl_extra $_flag_wsl_extra[-1]

    _wsl_wrapper_pwd --cmd=$cmd --win_extra=$win_extra --wsl_extra=$wsl_extra
end
