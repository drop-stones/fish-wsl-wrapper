# wslwrap.fish 🐟🐧

A lightweight Fish plugin that switches between Linux and Windows executables inside WSL2.

## 🔍 Overview

Some commands exist both in WSL2 (Linux) and on Windows (e.g. `git`, `fd`, `rg`).  
`wslwrap.fish` lets you register wrappers so that invoking the plain command name automatically picks the Windows `.exe` or the Linux binary depending on the current path.

Auto mode rule:

- Inside a Windows‑mounted path (e.g. under `/mnt/c/...`): run `command.exe`
- Elsewhere: run the Linux `command`

> [!IMPORTANT]
> Assumes standard WSL2 mount points (`/mnt/[drive]/`).
> Custom mount configurations may require manual adjustment.

## ✨ Key Features

- 🔀 **Smart Context Switching**: Seamlessly chooses Windows `.exe` vs Linux binary based on the current directory
- 🧠 **Zero Learning Curve**: Keeps muscle memory intact — no need to type `something.exe`
- 🚀 **Fast Windows Execution**: Uses both WSL2 PATH and `where.exe` for path resolution with built-in caching to minimize lookup time
- 🛡️ **PATH Independent**: Works even when Windows PATH isn't registered in WSL2's PATH environment
- ⚡ **Multi-level Caching**: System-wide and PATH-aware caching strategies for optimal performance
- 🔗 **System-wide Access**: Create symlinks for Windows executables accessible from any shell

## 🚀 Quick Start

Add registrations to your `config.fish` so they exist in every new shell:

```fish
# ~/.config/fish/config.fish
wslwrap register git
wslwrap register rg
wslwrap register fd --path-separator=/
```

Open a new shell and just use `git`, `rg`, `fd` normally.

## 🎯 Why wslwrap.fish?

### Performance Optimization

- **Smart Resolution**: Checks WSL2 PATH first, then falls back to `where.exe`
- **Direct Execution**: Bypasses repeated PATH searches for Windows executables

### Seamless Integration

- **No PATH Pollution**: Your WSL2 environment stays clean — no need to manually add Windows directories
- **Context Awareness**: Automatically detects whether you're working in a Windows or Linux context
- **System-wide Access**: Create symlinks for access from any shell or script

## Commands

### ⚙️ register

```fish
wslwrap register [--mode <auto|windows>] <command> [<args>...]
```

#### Modes

- `auto` (default) — Select Windows vs Linux based on the current path.
- `windows` — Always invoke the Windows executable (`command.exe`).

```fish
wslwrap register git                           # Simple auto switching
wslwrap register fd --path-separator=/         # Auto switching + default options
wslwrap register --mode windows rg             # Force Windows everywhere
```

> [!NOTE]
>
> - Omit `.exe` when registering.
> - Re-registering a command updates its configuration (mode, options).
> - Wrappers are not persisted; keep them in `~/.config/fish/config.fish` if you want them every session.

### 🗑️ unregister

Remove one or more wrappers:

```fish
wslwrap unregister git fd rg
```

> [!TIP]
> If you want to unregister all wrappers:
>
> ```fish
> wslwrap list | wslwrap unregister
> ```

### 📋 list

Show registered wrapper names:

```fish
wslwrap list
```

### 🔗 link

Create symlinks in `WSLWRAP_BIN_DIR` (default: `~/.local/share/wslwrap/bin`) for system-wide access to Windows executables:

```fish
wslwrap link <command> [<target_path>]
```

```fish
wslwrap link git                            # Auto-detect git.exe → $WSLWRAP_BIN_DIR/git
wslwrap link git.exe                        # Auto-detect git.exe → $WSLWRAP_BIN_DIR/git.exe
wslwrap link git /mnt/c/Git/bin/git.exe     # Explicit target path → $WSLWRAP_BIN_DIR/git
```

> [!NOTE]
> This plugin add `WSLWRAP_BIN_DIR` (default: `~/.local/share/wslwrap/bin`) to your `PATH` automatically.
> If you wish to customize the directory, see [⚙️ Configuration](#%EF%B8%8F-configuration) below.

### 🔓 unlink

Remove Windows executable symlinks from `WSLWRAP_BIN_DIR`:

```fish
wslwrap unlink <command> [<command> ...]
```

```fish
wslwrap unlink node git                     # Remove multiple symlinks
wslwrap links | wslwrap unlink              # Remove all Windows exe symlinks
echo "node git" | wslwrap unlink            # Pipe input support
```

> [!TIP]
> If you want to unlink all symlinks:
>
> ```fish
> wslwrap links | wslwrap unlink
> ```

### 📋 links

List Windows executable symlinks in `WSLWRAP_BIN_DIR`:

```fish
wslwrap links
```

### ❓ help

Show general or subcommand-specific help:

```fish
wslwrap help
wslwrap help register
wslwrap help link
```

## ⚙️ Configuration

### `WSLWRAP_PATH`: Search PATH for `wslwrap.fish`

Customize how `wslwrap.fish` searches for Windows executables by setting `WSLWRAP_PATH` as a **fish array** (space-separated directories):

```fish
set -gx WSLWRAP_PATH /mnt/c/Windows/System32 /mnt/c/Program\ Files/OtherTool
```

> [!TIP]
> If you use `direnv` or `mise`, you can dynamically change `WSLWRAP_PATH` on a per-project basis.
> This allows `wslwrap.fish` to resolve different Windows executables depending on your directory.

### `WSLWRAP_BIN_DIR`: Directory for Windows executable symlinks

Set `WSLWRAP_BIN_DIR` to customize where Windows executable symlinks are created:

```fish
set -gx WSLWRAP_BIN_DIR ~/my/custom/wslwrap/bin
```

## 📜 License

MIT License. See [LICENSE](LICENSE).
