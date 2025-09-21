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
- 🚀 **Fast Windows Execution**: Uses `where.exe` for path resolution with built-in caching to minimize lookup time
- 🛡️ **PATH Independent**: Works even when Windows PATH isn't registered in WSL2's PATH environment

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

- **Cached Path Resolution**: Windows executable paths are cached after first lookup, eliminating repeated PATH searches
- **Direct Execution**: Bypasses WSL2's PATH resolution for Windows executables

### Seamless Integration

- **No PATH Pollution**: Your WSL2 environment stays clean — no need to add Windows directories to your PATH
- **Context Awareness**: Automatically detects whether you're working in a Windows or Linux context

## Commands

### ⚙️ register

```fish
wslwrap register [--mode <auto|windows>] <command> [<args>...]
```

#### Modes

- `auto` (default) — Select Windows vs Linux based on the current path.
- `windows` — Always invoke the Windows executable (`command.exe`).

```fish
wslwrap register git                    # Simple auto switching
wslwrap register fd --path-separator=/  # Auto switching + default options
wslwrap register --mode windows rg      # Force Windows everywhere
```

> [!NOTE]
>
> - Omit `.exe` when registering.
> - Registration is idempotent (re-running does nothing).
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

### ❓ help

Show general or subcommand-specific help:

```fish
wslwrap help
wslwrap help register
```

## 📜 License

MIT License. See [LICENSE](LICENSE).
