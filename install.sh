#!/usr/bin/env bash
#
# Installs the dotfiles and everything they rely on.
# Supported: macOS (Homebrew) and Debian/Ubuntu (apt).
# Every step is idempotent: the script can be run again safely.
#
# Usage: ./install.sh [--skip-packages] [--skip-nvim]
#   --skip-packages  do not install system packages (brew / apt)
#   --skip-nvim      do not bootstrap Neovim plugins and Mason tools

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_PACKAGES=(nvim tmux zsh)
NVIM_MIN_VERSION="0.11.0"
NVM_VERSION="v0.40.1"
MASON_TOOLS=(lua-language-server typescript-language-server eslint-lsp css-lsp rust-analyzer stylua prettier)

SKIP_PACKAGES=false
SKIP_NVIM=false
for arg in "$@"; do
  case "$arg" in
    --skip-packages) SKIP_PACKAGES=true ;;
    --skip-nvim) SKIP_NVIM=true ;;
    -h | --help)
      sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m[warn] %s\033[0m\n' "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

if [ "$(id -u)" -eq 0 ]; then SUDO=""; else SUDO="sudo"; fi

# ─── System packages ─────────────────────────────────────────────────────────

install_macos_packages() {
  if ! have brew; then
    log "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Make brew available in this shell (Apple Silicon or Intel)
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  log "Installing Homebrew packages (Brewfile)"
  brew bundle --file "$DOTFILES_DIR/Brewfile"
}

install_neovim_linux() {
  if have nvim; then
    local current
    current="$(nvim --version | head -n1 | sed 's/^NVIM v//')"
    if [ "$(printf '%s\n%s\n' "$NVIM_MIN_VERSION" "$current" | sort -V | head -n1)" = "$NVIM_MIN_VERSION" ]; then
      log "Neovim $current already installed"
      return
    fi
  fi

  local arch
  case "$(uname -m)" in
    x86_64 | amd64) arch="x86_64" ;;
    aarch64 | arm64) arch="arm64" ;;
    *)
      warn "Unsupported architecture $(uname -m): install Neovim >= $NVIM_MIN_VERSION manually"
      return
      ;;
  esac

  log "Installing latest Neovim release (linux-$arch)"
  local tmp
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/nvim.tar.gz" \
    "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$arch.tar.gz"
  $SUDO rm -rf "/opt/nvim-linux-$arch"
  $SUDO tar -C /opt -xzf "$tmp/nvim.tar.gz"
  $SUDO ln -sf "/opt/nvim-linux-$arch/bin/nvim" /usr/local/bin/nvim
  rm -rf "$tmp"
}

install_nerd_font_linux() {
  # Only useful on a desktop (skipped on servers / containers)
  have fc-cache || return 0
  local font_dir="$HOME/.local/share/fonts/MesloLGNerdFont"
  [ -d "$font_dir" ] && return 0

  log "Installing Meslo LG Nerd Font"
  local tmp
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/Meslo.tar.xz" \
    "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz"
  mkdir -p "$font_dir"
  tar -C "$font_dir" -xJf "$tmp/Meslo.tar.xz"
  rm -rf "$tmp"
  fc-cache -f "$font_dir" >/dev/null
}

install_linux_packages() {
  if ! have apt-get; then
    warn "apt-get not found: only Debian/Ubuntu are automated."
    warn "Install manually: git curl zsh tmux stow ripgrep fzf tree make gcc unzip trash-cli xclip, then re-run with --skip-packages."
    exit 1
  fi

  log "Installing apt packages"
  $SUDO apt-get update
  DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y \
    build-essential ca-certificates curl git unzip tar xz-utils \
    zsh tmux stow ripgrep fzf tree \
    lua5.1 liblua5.1-0-dev luarocks \
    trash-cli xclip wl-clipboard fontconfig

  install_neovim_linux
  install_nerd_font_linux
}

# ─── Shell ───────────────────────────────────────────────────────────────────

install_shell() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing Oh My Zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  if [ ! -d "$HOME/powerlevel10k" ]; then
    log "Installing Powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
  fi

  local zsh_path
  zsh_path="$(command -v zsh || true)"
  if [ -n "$zsh_path" ] && [ "$(basename "${SHELL:-}")" != "zsh" ]; then
    log "Setting zsh as the default shell"
    grep -qx "$zsh_path" /etc/shells || echo "$zsh_path" | $SUDO tee -a /etc/shells >/dev/null
    $SUDO chsh -s "$zsh_path" "$(id -un)" || warn "chsh failed: run 'chsh -s $zsh_path' manually"
  fi
}

# ─── Node (needed by Mason for ts_ls / eslint / cssls / prettier) ────────────

install_node() {
  export NVM_DIR="$HOME/.nvm"
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    log "Installing nvm $NVM_VERSION"
    # PROFILE=/dev/null: the nvm lines are already in zsh/.zshrc
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | PROFILE=/dev/null bash
  fi

  # nvm.sh is not compatible with `set -u`
  set +u
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh" || true # returns non-zero until a default Node is installed
  if ! nvm ls --no-colors default >/dev/null 2>&1; then
    log "Installing Node LTS"
    nvm install --lts
    nvm alias default 'lts/*'
  fi
  nvm use default >/dev/null

  # nvim-treesitter (main branch) compiles parsers with the tree-sitter CLI
  if ! have tree-sitter; then
    log "Installing tree-sitter CLI"
    npm install -g tree-sitter-cli
  fi
  set -u
}

# ─── Symlinks (GNU Stow) ─────────────────────────────────────────────────────

backup_conflicts() {
  local stamp target
  stamp="$(date +%Y%m%d-%H%M%S)"
  for target in "$HOME/.config/nvim" "$HOME/.tmux.conf" "$HOME/.zshrc" "$HOME/.p10k.zsh"; do
    [ -e "$target" ] || [ -L "$target" ] || continue
    # Already linked to this repository: nothing to do
    if [ -L "$target" ] && [[ "$(realpath "$target" 2>/dev/null)" == "$DOTFILES_DIR"/* ]]; then
      continue
    fi
    warn "Backing up existing $target -> $target.$stamp.bak"
    mv "$target" "$target.$stamp.bak"
  done
}

link_dotfiles() {
  log "Linking dotfiles with stow: ${STOW_PACKAGES[*]}"
  # Create ~/.config first, otherwise stow would symlink the whole directory
  mkdir -p "$HOME/.config" "$HOME/.vim/undodir"
  backup_conflicts
  stow --restow --dir "$DOTFILES_DIR" --target "$HOME" "${STOW_PACKAGES[@]}"
}

# ─── tmux plugins ────────────────────────────────────────────────────────────

install_tmux_plugins() {
  local tpm="$HOME/.tmux/plugins/tpm"
  if [ ! -d "$tpm" ]; then
    log "Installing tmux plugin manager (tpm)"
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$tpm"
  fi
  log "Installing tmux plugins"
  "$tpm/bin/install_plugins" >/dev/null || warn "tpm failed: press prefix + I inside tmux"
}

# ─── Neovim ──────────────────────────────────────────────────────────────────

bootstrap_nvim() {
  log "Installing Neovim plugins (lazy.nvim)"
  nvim --headless "+Lazy! restore" +qa || warn "lazy.nvim restore failed: run :Lazy restore inside Neovim"

  log "Installing LSP servers and formatters (Mason)"
  nvim --headless "+MasonInstall ${MASON_TOOLS[*]}" +qa || warn "Mason failed: run :Mason inside Neovim"
}

# ─── Main ────────────────────────────────────────────────────────────────────

main() {
  case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux) OS="linux" ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
  log "Installing dotfiles from $DOTFILES_DIR ($OS)"

  if [ "$SKIP_PACKAGES" = false ]; then
    "install_${OS}_packages"
  fi

  install_shell
  install_node
  link_dotfiles
  install_tmux_plugins

  if [ "$SKIP_NVIM" = false ]; then
    bootstrap_nvim
  fi

  log "Done! Open a new terminal (or run 'exec zsh') to load the configuration."
}

main
