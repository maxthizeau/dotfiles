# Packages installed on macOS by ./install.sh (`brew bundle --file Brewfile`).

# Core tools
brew "git"
brew "neovim"
brew "tmux"
brew "stow"
brew "ripgrep"
brew "fzf"
brew "tree"

# `trash` is used by nvim-tree to delete files. It ships with macOS 15+,
# older versions need the Homebrew formula.
brew "trash" unless File.exist?("/usr/bin/trash")

# Terminal & font (Nerd Font needed for nvim-tree icons and Powerlevel10k)
cask "iterm2" unless File.exist?("/Applications/iTerm.app")
cask "font-meslo-lg-nerd-font"
