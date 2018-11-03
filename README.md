# Dotfiles

Personal dotfiles.

## Ubuntu 18.04 setup

The following describes a basic "from scratch" setup of my prefered environment

```sh
sudo apt update && apt upgrade -y

# Install core packages

sudo apt install -y \
build-essential \
libncurses-dev \
git \
emacs \
zsh gnome-tweak-tool \
curl \
i3

# Setup Git user information

git config --global user.email "owain@owainlewis.com"
git config --global user.name "Owain Lewis"

# Generate SSH keys

ssh-keygen -t rsa

# Use installer scripts for everything else i.e.

./scripts/chrome.sh
```
