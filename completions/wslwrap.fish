# All subcommands
set -l commands register unregister list add-path help

# subcommands
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments register --description "Register a wrapper (auto/windows)"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments unregister --description "Remove one or more registered wrappers"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments list --description "List registered wrapper names"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments add-path --description "Add Windows command directories to PATH"
complete --command wslwrap --condition "not __fish_seen_subcommand_from $commands" --no-files --arguments help --description "Show general or command-specific help"

# register: options
complete --command wslwrap --condition "_wslwrap_at 2 register" \
    --long-option mode \
    --require-parameter \
    --arguments "auto windows" \
    --no-files \
    --description "Registration mode"

complete --command wslwrap --condition "_wslwrap_at 2 register" \
    --long-option cache \
    --require-parameter \
    --arguments "system path" \
    --no-files \
    --description "Cache strategy"

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

# add-path: options
complete --command wslwrap --condition "_wslwrap_at 2 add-path" \
    --short-option a \
    --long-option append \
    --description "Add to end of PATH (lower priority, default)"

complete --command wslwrap --condition "_wslwrap_at 2 add-path" \
    --short-option p \
    --long-option prepend \
    --description "Add to beginning of PATH (higher priority)"

# add-path: no suggestions
complete --command wslwrap --condition "_wslwrap_at 2 add-path" \
    --no-files \
    --description "Command to add to PATH"

# help: suggest all subcommands
complete --command wslwrap --condition "_wslwrap_at 2 help; and test (count (commandline -xpc)) -eq 2" \
    --no-files \
    --arguments "(string match --invert help $commands)" \
    --description "Subcommand to show help"

complete --command wslwrap --condition "_wslwrap_at 2 help; and test (count (commandline -xpc)) -ge 3" --no-files
