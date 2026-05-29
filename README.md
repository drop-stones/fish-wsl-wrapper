# wslwrap.fish 🐟🐧

A lightweight Fish plugin that switches between Linux and Windows executables inside WSL2.

## 🔍 Overview

Some commands exist both in WSL2 (Linux) and on Windows (e.g. `git`, `fd`, `rg`).
`wslwrap.fish` lets you register wrappers so that invoking the plain command name automatically picks the Windows `.exe` or the Linux binary depending on the current path.

**Auto mode rule:**

- Inside `/mnt/[a-z]/...` → run `command.exe`
- Elsewhere → run the Linux `command`

> [!IMPORTANT]
> Assumes standard WSL2 mount points (`/mnt/[drive]/`).

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| **Smart Switching** | Chooses Windows `.exe` vs Linux binary based on current directory |
| **Zero Learning Curve** | No need to type `something.exe` — keeps muscle memory intact |
| **Fast Resolution** | Uses `WSLWRAP_PATH` and `where.exe` with built-in caching |
| **PATH Independent** | Works even when Windows PATH isn't in WSL2's PATH |
| **Symlink Support** | Create symlinks for system-wide access from any shell |

## 🚀 Quick Start

Add registrations to your `config.fish`:

```fish
# ~/.config/fish/config.fish
wslwrap register git
wslwrap register rg
wslwrap register fd --path-separator=/
```

Open a new shell and use `git`, `rg`, `fd` normally.

## 🛠️ Commands

### Quick Reference

| Command | Description |
|---------|-------------|
| `register [--mode auto\|windows] <cmd> [args]` | Register a wrapper |
| `unregister <cmd>...` | Remove wrappers |
| `list` | List registered wrappers |
| `link <cmd> [path]` | Create symlink for Windows exe |
| `unlink <cmd>...` | Remove symlinks |
| `links` | List symlinks |
| `clear` | Clear all wrappers and symlinks |
| `which [-a] <cmd>...` | Resolve command path (wslwrap-aware) |
| `help [cmd]` | Show help |

### register

Register a wrapper with optional mode and default arguments:

```fish
wslwrap register git                       # Auto switching
wslwrap register fd --path-separator=/     # With default options
wslwrap register --mode windows notepad    # Force Windows
```

| Mode | Behavior |
|------|----------|
| `auto` (default) | Windows exe in `/mnt/c/...`, Linux binary elsewhere |
| `windows` | Always use Windows executable |

> [!NOTE]
>
> - Omit `.exe` when registering
> - Re-registering a command updates its configuration
> - Wrappers are not persisted; add to `~/.config/fish/config.fish` for persistence

### link

Create symlinks in `WSLWRAP_BIN_DIR` (default: `~/.local/share/wslwrap/bin`):

```fish
wslwrap link node                          # Auto-detect node.exe
wslwrap link node /mnt/c/nodejs/node.exe   # Explicit target path
```

> [!NOTE]
>
> - `WSLWRAP_BIN_DIR` is automatically added to your `PATH`

### which

Resolve a command path, considering wslwrap wrappers. Registered wrappers resolve to the path the wrapper would actually invoke at the current directory; unregistered commands fall back to the system `which`.

```fish
wslwrap which git           # → /usr/bin/git (in Linux fs) or git.exe path (in /mnt/c/...)
wslwrap which -a fd         # All matches (wrapper resolution + which -a)
alias which 'wslwrap which' # Optional: make plain `which` wslwrap-aware
```

## ⚙️ Configuration

### `WSLWRAP_PATH`

Customize search paths for Windows executables (fish array):

```fish
set -gx WSLWRAP_PATH /mnt/c/Windows/System32 /mnt/c/Program\ Files/Git/bin
```

> [!TIP]
> Use `direnv` or `mise` to dynamically change `WSLWRAP_PATH` per directory, allowing different Windows executables depending on your project.

Embedded `\r` in each entry is stripped automatically (helps when `.envrc` lives on a Windows filesystem with CRLF line endings).

### `WSLWRAP_BIN_DIR`

Customize symlink directory (default: `~/.local/share/wslwrap/bin`):

```fish
set -gx WSLWRAP_BIN_DIR ~/my/custom/bin
```

## 📜 License

MIT License. See [LICENSE](LICENSE).
