#!/usr/bin/env bash

# Function to display a message
show_message() {
  echo -e "\n=========================================================="
  echo -e "$1"
  echo -e "==========================================================\n"
}

# Function to prompt user with a yes/no question
ask_question() {
  while true; do
    read -rp "$1 [y/n]: " yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer yes or no." ;;
    esac
  done
}

# Welcome message
show_message "Welcome to the Rootiest Neovim Installer!"

# Look for neovim executable
if ! command -v nvim &>/dev/null; then
  show_message "Neovim executable not found."
  if ! ask_question "Would you like to install it now?"; then
    show_message "Installation aborted by the user."
  else
    # Download neovim appimage
    mkdir -p ~/AppImages
    wget \
      https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
      -o ~/AppImages/nvim.appimage
    chmod +x ~/AppImages/nvim.appimage
    # Add neovim appimage to PATH
    export PATH=\"\$HOME/AppImages:\$PATH
    # Save neovim appimage to PATH in .bashrc
    echo "export PATH=\"\$HOME/AppImages:\$PATH\"" >>~/.bashrc
    # Save neovim appimage to PATH in .zshrc
    echo "export PATH=\"\$HOME/AppImages:\$PATH\"" >>~/.zshrc
    # Save neovim appimage to PATH in .config/fish/config.fish
    echo "set PATH \$HOME/AppImages \$PATH" >>~/.config/fish/config.fish
  fi
fi

# Verify neovim executable
if ! command -v nvim &>/dev/null; then
  show_message "Neovim installation failed.
Please install it manually and re-run the installer."
  exit 1
fi

# Initial prompt to proceed with installation
if ! ask_question \
  "Do you want to install the Rootiest Neovim configuration?"; then
  show_message "Installation aborted by the user."
  exit 1
fi

# Check if existing config is present and move to backup if confirmed
if [ -d ~/.config/nvim ]; then
  if ask_question \
    "Existing Neovim configuration found.
Do you want to backup and replace it?"; then
    mv ~/.config/nvim ~/.config/nvim.bkp
    show_message "Existing configuration has been backed up to ~/.config/nvim.bkp"
  else
    show_message "Operation aborted by the user."
    exit 1
  fi
fi

# Download rootiest neovim config
if git clone https://github.com/rootiest/rootiest-nvim ~/.config/nvim; then
  show_message "Rootiest Neovim configuration has been downloaded."
else
  show_message "Failed to download the configuration."
  exit 1
fi

# Start neovim
if ask_question "Do you want to start Neovim now?"; then
  nvim
else
  show_message "Neovim installation has been completed."
fi
