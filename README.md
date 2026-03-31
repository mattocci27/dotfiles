# Dotfiles

This repository contains configuration files for R, Visual Studio Code, tmux, Neovim (LazyVim), Zsh, Alacritty, and Radian. It also includes Cousine Nerd Fonts.

# Requirement

- Command Line Tools for Xcode

```shell
# command line tools
sudo xcode-select --install
```

# Usage

To set up your environment, clone this repository, install dependencies, and create symbolic links:

```shell
# Clone the repository
git clone https://github.com/mattocci27/dotfiles.git ~/dotfiles

# Navigate to the dotfiles directory
cd ~/dotfiles

# Install dependencies and create symbolic links
sh setup.sh
```

# Directory Structure

- **alacritty/**: Terminal emulator configuration
- **Code/**: VS Code settings and user preferences
- **deps/**: Dependency files (Brewfile, platform-specific install scripts)
- **fonts/**: Cousine Nerd Fonts
- **git/**: Git configuration and aliases
- **nvim/**: Neovim configuration (LazyVim)
- **R/**: R environment configuration and Makevars
- **radian/**: Enhanced R console configuration
- **scripts/**: Stow deployment and utility scripts
- **tmux/**: Terminal multiplexer configuration
- **zsh/**: Zsh shell configuration and aliases

# Platform Support

Supports macOS (Darwin) and Ubuntu with platform-specific dependency scripts.

# Sync Excludes

- `scripts/.sync/mini-rsync.excludes`: exclude list for `push-mini` / `pull-mini` / `push-ms` / `pull-ms`
- `scripts/.sync/vault-rsync.excludes`: exclude list for `push-vault-backup` / `pull-vault-backup`
- `scripts/.sync/gdrive-rclone.excludes`: exclude list for `gdrive-*` commands

# Homebrew

Homebrew mirror at [tsinghua uni](https://mirror.tuna.tsinghua.edu.cn/help/homebrew/)

# SSH Configuration (private)

- <https://github.com/mattocci27/dotssh>

# Zotero

- <https://github.com/retorquere/zotero-better-bibtex>

- <https://github.com/jlegewie/zotfile>
