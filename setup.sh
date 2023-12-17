#!/bin/bash

# Function to install or update a GitHub repository
install_or_update_git_repo() {
	local repo_url="$1"
	local clone_path="$2"

	if [ -d "$clone_path" ]; then
		echo "[INFO] Updating repository at $clone_path..."
		git -C "$clone_path" pull origin master
	else
		echo "[INFO] Cloning repository from $repo_url to $clone_path..."
		git clone "$repo_url" "$clone_path"
	fi
}

# Function to install or update a Homebrew package
install_or_update_brew_package() {
	local package_name="$1"

	echo "[INFO] Checking $package_name..."
	if brew list $package_name &>/dev/null; then
		echo "[INFO] $package_name is already installed. Updating..."
		brew upgrade $package_name
	else
		echo "[INFO] Installing $package_name..."
		brew install $package_name
	fi
}

# ---- Set Zsh as Default Shell (if not already set) ----
# DEFAULT_SHELL=$(echo $SHELL)
# ZSH_PATH=$(which zsh)

# if [ "$DEFAULT_SHELL" != "$ZSH_PATH" ]; then
#     echo "[INFO] Setting Zsh as the default shell..."
#     chsh -s $(which zsh)
# else
#     echo "[INFO] Zsh is already the default shell."
# fi

# ---- OMZ setup ----
# Install OMZ
# placeholder

# Install Starship Theme for OMZ
# placeholder

# ---- OMZ Plugin Setup ----
echo "[INFO] Installing OMZ plugins"
OMZ_PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

install_or_update_git_repo https://github.com/zsh-users/zsh-autosuggestions "$OMZ_PLUGIN_DIR/zsh-autosuggestions"
install_or_update_git_repo https://github.com/zsh-users/zsh-syntax-highlighting.git "$OMZ_PLUGIN_DIR/zsh-syntax-highlighting"

# ---- Homebrew Setup ----
# placeholder

# ---- Tmux Setup ----
install_or_update_brew_package tmux

# Install TPM
echo "[INFO] Installing TPM (Tmux Plugin Manager)"
TPM_DIR="$HOME/.tmux/plugins/tpm"

install_or_update_git_repo https://github.com/tmux-plugins/tpm "$TPM_DIR"

# ---- NeoVim Setup ----
install_or_update_brew_package neovim

# Optional lazy.vim dependencies
install_or_update_brew_package ripgrep
install_or_update_brew_package fd

# ---- symlinks setup ----
CURRENT_DIR=$(pwd)
echo "[INFO] Creating dotfile symlinks..."
ln -sf $CURRENT_DIR/nvim ~/.config
ln -sf $CURRENT_DIR/.zshrc ~
ln -sf $CURRENT_DIR/.tmux.conf ~
