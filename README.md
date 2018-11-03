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

# Install Emacs 26

sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt install -y emacs26

# Install Chrome

wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f

# Install Haskell Stack

curl -sSL https://get.haskellstack.org/ | sh

# Install Oh My ZSH

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Golang

wget -q https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x installer_linux
./installer_linux
```
