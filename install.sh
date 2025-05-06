#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing copy-btn Zsh plugin...${NC}"

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}Error: Zsh is not installed. Please install Zsh first.${NC}"
    exit 1
fi

# Check if a clipboard utility is available
CLIPBOARD_UTIL=""
if command -v pbcopy &> /dev/null; then
    CLIPBOARD_UTIL="pbcopy"
elif command -v xclip &> /dev/null; then
    CLIPBOARD_UTIL="xclip"
elif command -v wl-copy &> /dev/null; then
    CLIPBOARD_UTIL="wl-copy"
elif command -v win32yank.exe &> /dev/null; then
    CLIPBOARD_UTIL="win32yank.exe"
else
    echo -e "${YELLOW}Warning: No clipboard utility found.${NC}"
    echo -e "Please install one of the following based on your system:"
    echo -e "  - macOS: pbcopy (built-in)"
    echo -e "  - Linux X11: xclip (sudo apt-get install xclip)"
    echo -e "  - Linux Wayland: wl-clipboard (sudo apt-get install wl-clipboard)"
    echo -e "  - Windows WSL: win32yank (curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip && unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe && chmod +x /tmp/win32yank.exe && sudo mv /tmp/win32yank.exe /usr/local/bin/)"
    echo -e "${YELLOW}Continuing installation anyway...${NC}"
fi

# Determine installation directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Detect Oh My Zsh
OMZ_PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
if [ -d "$OMZ_PLUGINS_DIR" ]; then
    INSTALL_DIR="$OMZ_PLUGINS_DIR/copy-btn"
    
    # Create plugin directory
    mkdir -p "$INSTALL_DIR"
    
    # Copy plugin file
    cp "$SCRIPT_DIR/copy-btn.plugin.zsh" "$INSTALL_DIR/"
    
    echo -e "${GREEN}Plugin installed to $INSTALL_DIR${NC}"
    echo -e "${YELLOW}Don't forget to add 'copy-btn' to your plugins list in ~/.zshrc:${NC}"
    echo -e "plugins=(... ${BLUE}copy-btn${NC})"
else
    # Manual installation
    INSTALL_DIR="$HOME/.zsh/plugins/copy-btn"
    
    # Create plugin directory
    mkdir -p "$INSTALL_DIR"
    
    # Copy plugin file
    cp "$SCRIPT_DIR/copy-btn.plugin.zsh" "$INSTALL_DIR/"
    
    echo -e "${GREEN}Plugin installed to $INSTALL_DIR${NC}"
    echo -e "${YELLOW}Add the following line to your ~/.zshrc file:${NC}"
    echo -e "source $INSTALL_DIR/copy-btn.plugin.zsh"
fi

# Make plugin file executable
chmod +x "$INSTALL_DIR/copy-btn.plugin.zsh"

if [ -n "$CLIPBOARD_UTIL" ]; then
    echo -e "${GREEN}Detected clipboard utility: $CLIPBOARD_UTIL${NC}"
else 
    echo -e "${YELLOW}Remember to install a clipboard utility before using the plugin.${NC}"
fi

echo -e "${GREEN}Installation complete!${NC}"
echo -e "${BLUE}Reload your shell or run 'source ~/.zshrc' to start using copy-btn.${NC}" 