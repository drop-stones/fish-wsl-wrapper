# fish-wsl-wrapper

🐟 Fish plugin that switches between Linux and Windows executables in WSL2, based on context.

## 🔍 Overview

When working inside **WSL2**, some commands may exist both in the Linux environment and on Windows (e.g. `git`, `fd`, `bat`).  
This plugin provides a simple mechanism to **register wrapper functions** that automatically choose which executable to run depending on the current working directory.

- If the current directory is under `/mnt/*`, the Windows `.exe` will be executed.
- Otherwise, the Linux executable is used.
- Extra arguments can be attached for either side (`win_extra`, `wsl_extra`).

This avoids the need to manually type `git.exe`, `fd.exe`, etc. when working with Windows paths.

## 📦 Installation

With [fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install drop-stones/fish-wsl-wrapper
```

## 🚀 Usage

### ✨ Register a wrapper

```fish
wsl_wrapper_register git
```

Now `git` will:

- Run `git.exe` when invoked inside `/mnt/*`
- Run `git` (Linux) otherwise

### ⚙️ With extra arguments

```fish
wsl_wrapper_register fd --win_extra="--path-separator=\\" --wsl_extra="--path-separator=/"
```

In `/mnt/*`, runs:

```fish
fd.exe --path-separator=\ <your args>
```

Elsewhere:

```fish
fd --path-separator=/ <your args>
```

## 📝 Notes

- Currently only **pwd-based switching** is supported (no argument-based detection)
- If you no longer want a wrapper, you can remove it with:

```fish
functions -e git
```

- This plugin is primarily designed for **WSL2 users**. It won't activate on plain Linux/macOS/Windows.

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
