#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Terminal Setup ==="

# 1. Install MesloLGS NF font
FONT_DIR="$HOME/Library/Fonts"
if [ "$(uname)" = "Linux" ]; then
  FONT_DIR="$HOME/.local/share/fonts"
fi
mkdir -p "$FONT_DIR"
if ! ls "$FONT_DIR"/MesloLGS* &>/dev/null; then
  echo "[1/7] Installing MesloLGS NF font..."
  MESLO_BASE="https://github.com/romkatv/powerlevel10k-media/raw/master"
  curl -fsSL "$MESLO_BASE/MesloLGS%20NF%20Regular.ttf" -o "$FONT_DIR/MesloLGS NF Regular.ttf"
  curl -fsSL "$MESLO_BASE/MesloLGS%20NF%20Bold.ttf" -o "$FONT_DIR/MesloLGS NF Bold.ttf"
  curl -fsSL "$MESLO_BASE/MesloLGS%20NF%20Italic.ttf" -o "$FONT_DIR/MesloLGS NF Italic.ttf"
  curl -fsSL "$MESLO_BASE/MesloLGS%20NF%20Bold%20Italic.ttf" -o "$FONT_DIR/MesloLGS NF Bold Italic.ttf"
  if [ "$(uname)" = "Linux" ]; then
    fc-cache -f "$FONT_DIR"
  fi
else
  echo "[1/7] MesloLGS NF font already installed, skipping."
fi

# 2. Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[2/7] Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "[2/7] Oh My Zsh already installed, skipping."
fi

# 3. Install Oh My Zsh plugins
echo "[3/7] Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
[ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ] && \
  git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM/plugins/zsh-z" || true

# 4. Install zsh-syntax-highlighting
if command -v brew &>/dev/null; then
  if ! brew list zsh-syntax-highlighting &>/dev/null; then
    echo "[4/7] Installing zsh-syntax-highlighting via Homebrew..."
    brew install zsh-syntax-highlighting
  else
    echo "[4/7] zsh-syntax-highlighting already installed, skipping."
  fi
else
  echo "[4/7] Installing zsh-syntax-highlighting via git..."
  ZSH_SH_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  [ ! -d "$ZSH_SH_DIR" ] && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_SH_DIR" || true
fi

# 5. Append .zshrc config (before starship install so starship adds its init line)
echo "[5/7] Appending .zshrc config..."
# Only append if not already applied (use a marker comment)
MARKER="# === ghostty-dotfiles ==="
if ! grep -qF "$MARKER" ~/.zshrc 2>/dev/null; then
  {
    echo ""
    echo "$MARKER"
    cat "$SCRIPT_DIR/.zshrc"
  } >> ~/.zshrc
  echo "  Appended config to ~/.zshrc"
else
  echo "  Config already present in ~/.zshrc, skipping."
fi

# 6. Install Starship (adds eval "$(starship init zsh)" to end of ~/.zshrc)
if ! command -v starship &>/dev/null; then
  echo "[6/7] Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "[6/7] Starship already installed, skipping."
fi
# Ensure starship init is at the end of .zshrc
if ! grep -qF 'eval "$(starship init zsh)"' ~/.zshrc 2>/dev/null; then
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
  echo '  Added starship init to ~/.zshrc'
fi

# 6b. Copy starship.toml
mkdir -p ~/.config
cp "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml

# 7. Copy Ghostty config
echo "[7/7] Configuring Ghostty..."
mkdir -p ~/.config/ghostty
if [ -f ~/.config/ghostty/config ]; then
  cp ~/.config/ghostty/config ~/.config/ghostty/config.bak
  echo "  Backed up existing config to ~/.config/ghostty/config.bak"
fi
cp "$SCRIPT_DIR/ghostty/config" ~/.config/ghostty/config

echo ""
echo "=== Done! ==="
echo "Restart your terminal or run: source ~/.zshrc"
