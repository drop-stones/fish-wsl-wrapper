# wslwrap.fish 🐟🔀

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
- 🛤️ **PATH Management**: Easily add Windows command directories to your PATH

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

- **Multi-level Caching**: Windows executable paths are cached with configurable strategies
  - **System cache**: Persistent across all sessions (default)
  - **Path cache**: Cleared when PATH changes, suitable for dynamic environments
- **Smart Resolution**: Checks WSL2 PATH first, then falls back to `where.exe`
- **Direct Execution**: Bypasses repeated PATH searches for Windows executables

### Seamless Integration

- **No PATH Pollution**: Your WSL2 environment stays clean — no need to manually add Windows directories
- **Context Awareness**: Automatically detects whether you're working in a Windows or Linux context
- **PATH Management**: Built-in tools to selectively add Windows command directories

## Commands

### ⚙️ register

```fish
wslwrap register [--mode <auto|windows>] [--cache <system|path>] <command> [<args>...]
```

#### Modes

- `auto` (default) — Select Windows vs Linux based on the current path.
- `windows` — Always invoke the Windows executable (`command.exe`).

#### Cache Strategies

- `system` (default) — Cache persistently across all sessions.
- `path` — Follow PATH changes, cleared when PATH is modified.

> [!TIP]
> The `path` cache strategy works well with mise, direnv, or any tool that modifies PATH dynamically.

```fish
wslwrap register git                           # Simple auto switching with system cache
wslwrap register fd --path-separator=/         # Auto switching + default options
wslwrap register --mode windows rg             # Force Windows everywhere
wslwrap register --cache path node             # PATH-aware caching
wslwrap register --mode auto --cache system fd # Explicit mode and cache specification
```

> [!NOTE]
>
> - Omit `.exe` when registering.
> - Re-registering a command updates its configuration (mode, cache strategy, options).
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

### 🛤️ add-path

Add directories containing Windows commands to your PATH:

```fish
wslwrap add-path [-a|--append] [-p|--prepend] <command> [<command> ...]
```

#### Options

- `-a, --append` — Add to end of PATH (lower priority, default).
- `-p, --prepend` — Add to beginning of PATH (higher priority).

```fish
wslwrap add-path win32yank              # Add win32yank directory to PATH
wslwrap add-path --prepend node npm     # Add Node.js tools with high priority
wslwrap add-path clip notepad winget    # Add multiple Windows tool directories
```

> [!TIP]
> Particularly useful when you have `appendWindowsPath = false` in your `.wslconfig`:
>
> ```ini
> [interop]
> appendWindowsPath = false
> ```
>
> Use `add-path` to selectively add only the Windows tools you need, avoiding PATH pollution while maintaining access to essential Windows executables.

### ❓ help

Show general or subcommand-specific help:

```fish
wslwrap help
wslwrap help register
wslwrap help add-path
```

## 📜 License

MIT License. See [LICENSE](LICENSE).
