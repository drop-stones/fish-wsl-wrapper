# All subcommands
set -l commands register unregister list link unlink links help

# subcommands
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments register --description "Register a wrapper (auto/windows)"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments unregister --description "Remove one or more registered wrappers"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments list --description "List registered wrapper names"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments link --description "Create symlinks for Windows executables"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments unlink --description "Remove Windows executable symlinks"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments links --description "List Windows executable symlinks"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments help --description "Show general or command-specific help"

# register: options
complete --command wslwrap --condition "_wslwrap_at 2 register" \
    --long-option mode \
    --require-parameter \
    --arguments "auto windows" \
    --no-files \
    --description "Registration mode"

# register: suggest all commands
complete --command wslwrap --condition "_wslwrap_at 2 register && test (_wslwrap_get_command_index) -eq 0" \
    --no-files \
    --arguments "(__fish_complete_command)" \
    --description "Command to register"

# register: delegate to command completion
complete --command wslwrap --condition "_wslwrap_at 2 register && test (_wslwrap_get_command_index) -ne 0" \
    --keep-order \
    --arguments "(_wslwrap_delegate_complete (_wslwrap_get_command_index))"

# unregister: suggest registered commands
complete --command wslwrap --condition "_wslwrap_at 2 unregister" \
    --no-files \
    --arguments "(_wslwrap_unused_from 3 (wslwrap list))" \
    --description "Targets to unregister"

# list: no arguments
complete --command wslwrap --condition "_wslwrap_at 2 list" --no-files

# link: optional path completion
complete --command wslwrap --condition "_wslwrap_at 2 link && test (count (commandline -xpc)) -eq 2" --no-files
complete --command wslwrap --condition "_wslwrap_at 2 link && test (count (commandline -xpc)) -eq 3" --description "Path to Windows executable"

# unlink: suggest linked commands
complete --command wslwrap --condition "_wslwrap_at 2 unlink" \
    --no-files \
    --arguments "(_wslwrap_unused_from 3 (wslwrap links))" \
    --description "Symlinks to unlink"

# links: no arguments
complete --command wslwrap --condition "_wslwrap_at 2 links" --no-files

# help: suggest all subcommands
complete --command wslwrap --condition "_wslwrap_at 2 help; and test (count (commandline -xpc)) -eq 2" \
    --no-files \
    --arguments "(string match --invert help $commands)" \
    --description "Subcommand to show help"

complete --command wslwrap --condition "_wslwrap_at 2 help; and test (count (commandline -xpc)) -ge 3" --no-files
