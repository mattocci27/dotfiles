# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository containing configuration files for development tools including R, Visual Studio Code, tmux, Neovim (NvChad), Zsh, Alacritty, and Ranger. The repository uses GNU Stow for managing symbolic links to create a unified dotfiles management system.

## Setup and Installation Commands

### Initial Setup
```bash
# Full environment setup (interactive menu)
sh setup.sh

# Direct installation with dependencies and symlinks  
sh install.sh
```

### Core Installation Steps
```bash
# Install system dependencies (macOS)
sh deps/dependencies-Darwin

# Install Homebrew packages
brew bundle --file deps/Brewfile

# Create symlinks using stow
sh scripts/.dotscripts/deploy.sh
```

### Individual Component Installation
```bash
# Install Rust tools
cargo install dutree bottom zoxide --locked

# Install Python environment
curl https://pyenv.run | bash
pyenv install 3.12.2 && pyenv global 3.12.2
pip install -U radian pynvim

# Install R packages
Rscript -e "install.packages(c('littler', 'pacman', 'tidyverse', 'vegan', 'renv'), dependencies = TRUE)"

# Install NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Architecture

### Directory Structure
The repository follows a stow-compatible directory structure where each top-level directory represents a different application or tool configuration:

- **alacritty/**: Terminal emulator configuration
- **Code/**: VS Code settings, snippets, and user preferences
- **git/**: Git configuration and aliases
- **nvim/**: Neovim configuration files
- **R/**: R environment configuration and Makevars
- **radian/**: Enhanced R console configuration
- **ranger/**: File manager configuration  
- **tmux/**: Terminal multiplexer configuration
- **zellij/**: Modern terminal workspace configuration
- **zsh/**: Zsh shell configuration and aliases

### Key Files
- `setup.sh`: Interactive setup script with menu options for different installation steps
- `install.sh`: Direct installation script that handles dependencies and stow deployment
- `deps/Brewfile`: Homebrew bundle file containing all macOS dependencies
- `deps/dependencies-*`: Platform-specific dependency installation scripts
- `scripts/.dotscripts/deploy.sh`: Stow deployment script that creates all symlinks

### Stow Management
The repository uses GNU Stow to manage symbolic links. Each configuration directory is stowed to create symlinks in the user's home directory, allowing centralized management of dotfiles while maintaining the expected file locations for each application.

### Platform Support
Supports macOS (Darwin), Ubuntu, and Manjaro Linux with platform-specific dependency files and installation procedures.