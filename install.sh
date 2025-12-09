#!/usr/bin/env bash
set -euo pipefail

USER_HOME="$HOME"
BACKUP_DIR="$USER_HOME/dotfiles_backup_$(date +%s)"
mkdir -p "$BACKUP_DIR"

echo "[*] Backup directory: $BACKUP_DIR"

# Backup existing configs
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$BACKUP_DIR/.zshrc.bak"
[ -f "$HOME/.p10k.zsh" ] && mv "$HOME/.p10k.zsh" "$BACKUP_DIR/.p10k.zsh.bak"

echo "[*] Installing dependencies..."
sudo apt update
sudo apt install -y zsh git curl wget fzf tldr net-tools nmap \
 zsh-autosuggestions zsh-syntax-highlighting fonts-powerline unzip p7zip-full

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[*] Installing Oh-My-Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
fi

# Install Powerlevel10k
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "[*] Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# Write new .zshrc
echo "[*] Installing .zshrc..."
cp "$(dirname "$0")/zshrc" "$HOME/.zshrc"

echo "[*] Installation complete!"
echo "→ Ejecuta: exec zsh"
echo "→ Luego: p10k configure"

