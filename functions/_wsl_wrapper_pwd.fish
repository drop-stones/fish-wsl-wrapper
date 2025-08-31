# _wsl_wrapper_pwd.fish
# Internal helper to define a wrapper function that selects Windows (.exe) or WSL binary
# depending on whether the current working directory is under /mnt/.
function _wsl_wrapper_pwd --description "Create a pwd-based wrapper for Windows/WSL command"
    set -f options_spec 'cmd=' 'win_extra=?' 'wsl_extra=?'
    argparse $options_spec -- $argv; or return 1

    if not set -ql _flag_cmd[1]; or test -z $_flag_cmd[-1]
        echo "Error: --cmd option requires a non-empty argument."
        return 1
    end

    set -f cmd $_flag_cmd[-1]
    set -f win_extra $_flag_win_extra[-1]
    set -f wsl_extra $_flag_wsl_extra[-1]

    function $cmd --inherit-variable cmd --inherit-variable win_extra --inherit-variable wsl_extra --description "Wrapper for $cmd that switches between Windows and WSL executables"
        if string match -q "/mnt/*" (realpath -q (pwd))
            command $cmd.exe $win_extra $argv
        else
            command $cmd $wsl_extra $argv
        end
    end
end
