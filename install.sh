#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

DRY_RUN=false
ONLY="all"
PLATFORM_TEST=""

info() { printf "\033[34m==>\033[0m %s\n" "$1"; }
ok()   { printf "\033[32m  ✓\033[0m %s\n" "$1"; }
warn() { printf "\033[33m  !\033[0m %s\n" "$1"; }
err()  { printf "\033[31m  ✗\033[0m %s\n" "$1" >&2; }

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Options:
  --dry-run                 Print actions without making changes
  --only <git|ghostty>      Link only one config target
  --platform-test <name>    Override detected platform (for testing)
  -h, --help                Show this help
EOF
}

run() {
  if [[ "$DRY_RUN" == true ]]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --only)
      if [[ $# -lt 2 ]]; then
        err "--only requires a value: git or ghostty"
        exit 1
      fi
      ONLY="$2"
      shift 2
      ;;
    --platform-test)
      if [[ $# -lt 2 ]]; then
        err "--platform-test requires a value"
        exit 1
      fi
      PLATFORM_TEST="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      err "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

case "$ONLY" in
  all|git|ghostty|pi) ;;
  *)
    err "Invalid --only value '$ONLY'. Expected one of: git, ghostty, pi"
    exit 1
    ;;
esac

platform="${PLATFORM_TEST:-$(uname -s)}"
platform="$(printf '%s' "$platform" | tr '[:upper:]' '[:lower:]')"

case "$platform" in
  darwin|linux)
    ok "Platform: $platform"
    ;;
  *)
    err "Unsupported platform: $platform"
    err "This installer supports: darwin, linux"
    exit 1
    ;;
esac

ensure_brew() {
  info "Homebrew"
  if command -v brew >/dev/null 2>&1; then
    ok "Homebrew already installed"
    return
  fi

  if [[ "$platform" != "darwin" && "$platform" != "linux" ]]; then
    err "Homebrew install unsupported on platform: $platform"
    exit 1
  fi

  info "Installing Homebrew"
  if [[ "$DRY_RUN" == true ]]; then
    echo "[dry-run] /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  ok "Homebrew"
}

ensure_packages() {
  info "Packages"
  if command -v stow >/dev/null 2>&1; then
    ok "stow already installed"
    return
  fi

  if ! command -v brew >/dev/null 2>&1; then
    err "brew is not available to install stow"
    exit 1
  fi

  run brew install stow
  ok "Packages"
}

ensure_font() {
  info "Font"
  if [[ "$platform" != "darwin" ]]; then
    warn "Skipping JetBrains Mono install (non-macOS platform)"
    ok "JetBrains Mono (skipped)"
    return
  fi

  if brew list --cask font-jetbrains-mono >/dev/null 2>&1; then
    ok "JetBrains Mono already installed"
    return
  fi

  run brew install --cask font-jetbrains-mono
  ok "JetBrains Mono"
}

link_configs() {
  info "Linking configs"

  local targets
  if [[ "$ONLY" == "all" ]]; then
    targets=(ghostty git)
  else
    targets=("$ONLY")
  fi

  run mkdir -p "$HOME/.config"

  if [[ "$DRY_RUN" == true ]]; then
    echo "[dry-run] cd $DOTFILES"
    echo "[dry-run] stow ${targets[*]}"
  else
    cd "$DOTFILES"
    stow "${targets[@]}"
  fi

  # Pi coding agent (targets ~/.pi, not ~/.config)
  run mkdir -p "$HOME/.pi"
  if [[ "$DRY_RUN" == true ]]; then
    echo "[dry-run] stow -t ~/.pi pi"
  else
    cd "$DOTFILES"
    stow -t "$HOME/.pi" pi
  fi

  ok "Done"
}

ensure_brew
ensure_packages
ensure_font
link_configs

echo ""
echo "Open a new Ghostty window to pick up changes."
