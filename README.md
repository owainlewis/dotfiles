# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

- **ghostty** -- terminal config (Tokyo Night, JetBrains Mono, split panes)
- **git** -- global git config (interactive setup) and ignore patterns
- **pi** -- [Pi coding agent](https://pi.dev) settings (model, provider, skills)

## Install

```bash
git clone https://github.com/owainlewis/dotfiles.git ~/.config/dotfiles
cd ~/.config/dotfiles
./install.sh
```

The install script will:

1. Install Homebrew (if missing)
2. Install GNU Stow
3. Install JetBrains Mono font (skips gracefully if already present)
4. Symlink configs into `~/.config/` via Stow (and `~/.pi/` for Pi)
5. **Interactive Git setup** — prompts for your name, email, and preferred editor (only on first run)

## Structure

Each top-level directory maps to a config folder that gets symlinked into `~/.config/`. The `.stowrc` file sets `~/.config` as the target directory.
