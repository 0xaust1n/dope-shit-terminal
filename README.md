# Ghostty Terminal Setup

My terminal config for [Ghostty](https://ghostty.org/) + Oh My Zsh + Starship.

## Quick Start

```bash
git clone https://github.com/0xaust1n/dope-shit-terminal.git ~/dope-shit-terminal && cd ~/dope-shit-terminal && bash setup.sh
```

## What's Included

### Ghostty Config

| Setting | Value |
|---------|-------|
| Font | MesloLGS NF, 14pt |
| Theme | Catppuccin Mocha |
| Background | 85% opacity + blur |
| Titlebar | Transparent (macOS) |
| Cursor | Bar, blinking |
| Quick Terminal | `Ctrl+`` ` (Quake-style dropdown) |

**Keybindings:**

| Shortcut | Action |
|----------|--------|
| `Cmd+T` | New tab |
| `Cmd+W` | Close tab |
| `Cmd+Shift+Left/Right` | Switch tabs |
| `Cmd+D` | Split right |
| `Cmd+Shift+D` | Split down |
| `Cmd+Shift+Arrow` | Navigate splits |
| `Cmd+Shift+E` | Equalize splits |
| `Cmd+Shift+F` | Toggle split zoom |
| `Cmd+Plus/Minus/Zero` | Font size |
| `Cmd+Shift+R` | Reload config |

### Zsh Aliases

```
c           → clear
szsh        → source ~/.zshrc
ipconfig    → ifconfig en0
fuckAudio   → sudo killall coreaudiod
vs          → open VS Code
cr          → open Cursor
ag          → open Antigravity
pi/pb/pd/pu → pnpm install/build/dev/update -i
yd          → yarn dev
md          → make d
cc          → claude (bypass permissions)
cx          → codex (full access)
gay         → gemini
gas         → gh auth switch
```

### Secrets

`~/.zshrc` sources `~/.zshrc.local` if it exists. Keep API keys and tokens
there — it is never committed.

### Zsh Plugins

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-z](https://github.com/agkozak/zsh-z)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### Starship

Minimal config — disables the blank line before each prompt (`add_newline = false`)
and raises `command_timeout` to 2000ms so git modules don't drop out on large repos.

## What `setup.sh` Does

1. Installs **MesloLGS NF** font (Regular, Bold, Italic, Bold Italic)
2. Installs **Oh My Zsh**
3. Clones zsh plugins (autosuggestions, zsh-z)
4. Installs **zsh-syntax-highlighting** (Homebrew or git)
5. **Appends** zsh config to existing `~/.zshrc` (won't duplicate)
6. Installs **Starship** + adds `eval "$(starship init zsh)"` to end of `~/.zshrc`
7. Copies **Ghostty config** + **starship.toml**

> Existing configs are backed up as `.bak` before overwriting.

## File Structure

```
.
├── ghostty/config   → ~/.config/ghostty/config
├── .zshrc           → appended to ~/.zshrc
├── starship.toml    → ~/.config/starship.toml
├── setup.sh         → one-liner installer
└── README.md
```
