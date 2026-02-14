#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from your home directory to the dotfiles repo

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${GREEN}🚀 Installing dotfiles from: $DOTFILES_DIR${NC}\n"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # If target exists and is not a symlink, back it up
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}  Backing up existing: $target${NC}"
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        rm "$target"
    fi

    # Create symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}  ✓ Linked: $target → $source${NC}"
}

# Install Neovim config
echo -e "${GREEN}📝 Checking Neovim config...${NC}"
# Only create symlink if dotfiles repo is NOT already at ~/.config
if [ "$DOTFILES_DIR" != "$HOME/.config" ]; then
    create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
else
    echo -e "${GREEN}  ✓ Neovim config already in place at ~/.config/nvim${NC}"
fi

# Install tmux config
echo -e "\n${GREEN}🖥️  Installing tmux config...${NC}"
create_symlink "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Install Ghostty config
echo -e "\n${GREEN}👻 Installing Ghostty config...${NC}"
create_symlink "$DOTFILES_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# Remove old config file if it exists
if [ -f "$HOME/.config/.tmux.conf" ]; then
    echo -e "\n${YELLOW}🧹 Cleaning up old tmux config at ~/.config/.tmux.conf${NC}"
    mv "$HOME/.config/.tmux.conf" "$HOME/.config/.tmux.conf.old.$(date +%Y%m%d_%H%M%S)"
fi

echo -e "\n${GREEN}✨ Dotfiles installation complete!${NC}"
echo -e "\n${YELLOW}📋 Next steps:${NC}"
echo -e "  1. Restart your terminal or run: source ~/.zshrc (or ~/.bashrc)"
echo -e "  2. For tmux: Install TPM (Tmux Plugin Manager) if not already installed:"
echo -e "     git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"
echo -e "  3. In tmux, press ${GREEN}Ctrl+s${NC} then ${GREEN}I${NC} (capital i) to install plugins"
echo -e "  4. For Ghostty: Reload config with ${GREEN}Cmd+Shift+,${NC}"
echo -e "  5. For Polish characters in Ghostty: Use ${GREEN}Right Option${NC} key + letter"
echo -e "\n${GREEN}Happy coding! 🎉${NC}\n"
