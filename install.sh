/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl https://sh.rustup.rs -sSf | sh # install rust and cargo, used in dependencies (json parser/dap)

brew install stow
# stow dotfiles
stow -R nvim
stow -R tmux
stow -R .tmux
stow -R zsh

# # add zsh as a login shell
# command -v zsh | sudo tee -a /etc/shells

# # use zsh as default shell
# sudo chsh -s $(which zsh) $USER
#
#
#
#Add this to the $Home/cargo/config https://github.com/Joakker/lua-json5
# [target.x86_64-apple-darwin]
# rustflags = [
#     "-C", "link-arg=-undefined",
#     "-C", "link-arg=dynamic_lookup",
# ]
#
# [target.aarch64-apple-darwin]
# rustflags = [
#     "-C", "link-arg=-undefined",
#     "-C", "link-arg=dynamic_lookup",
# ]
