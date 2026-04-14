#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info() { printf "\033[34m==>\033[0m %s\n" "$1"; }
ok()   { printf "\033[32m  ✓\033[0m %s\n" "$1"; }

# Homebrew
if ! command -v brew &>/dev/null; then
    info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
ok "Homebrew"

# Packages
for pkg in stow; do
    command -v "$pkg" &>/dev/null || brew install "$pkg"
done
ok "Packages"

# Font
if ! brew list --cask font-jetbrains-mono &>/dev/null 2>&1; then
    info "Installing JetBrains Mono"
    brew install --cask font-jetbrains-mono
fi
ok "JetBrains Mono"

# Link
info "Linking configs"
mkdir -p ~/.config
cd "$DOTFILES"
stow .
ok "Done"

echo ""
echo "Open a new Ghostty window to pick up changes."
