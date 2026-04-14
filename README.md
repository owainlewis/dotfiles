# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

- **ghostty** -- terminal config (Tokyo Night, JetBrains Mono, split panes)
- **git** -- global git config and ignore patterns

## Install

```bash
git clone https://github.com/owainlewis/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
./install.sh
```

The install script will:

1. Install Homebrew (if missing)
2. Install GNU Stow
3. Install JetBrains Mono font
4. Symlink configs into `~/.config/` via Stow

## Structure

Each top-level directory maps to a config folder that gets symlinked into `~/.config/`. The `.stowrc` file sets `~/.config` as the target directory.
