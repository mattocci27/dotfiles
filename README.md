# Dotfiles

This repository contains configuration files for R, Visual Studio Code, Zed, tmux, Neovim (LazyVim), Zsh, Alacritty, and Radian. It also includes Cousine Nerd Fonts.

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
- **zed/**: Zed settings, native Vim keymap, tasks, and Markdown snippets
- **zsh/**: Zsh shell configuration and aliases

# Zed

On macOS, the Brew bundle installs Zed; the `zed/` package is stowed to `~/.config/zed` by the existing deployment scripts. It uses Zed's native Vim mode with `Space` as the normal-mode leader and native which-key with no display delay; standalone Neovim remains independent.

Zed auto-installs the `R`, `Air`, `Quarto`, and `Gruvbox Material` extensions. R uses Air for formatting and `r_language_server` for language intelligence; setup option 6 installs the required `languageserver` and `lintr` R packages. `SPC t r` starts the existing `radian` command in a Zed terminal.

`.qmd` uses the young, grammar-only Quarto extension (currently `0.0.1`); `.Rmd` and `.rmd` use Markdown. Fenced R code is highlighted when the R extension is installed, and global tasks provide Quarto preview/render plus R Markdown render (`SPC q`). Zed does not provide Quarto's full notebook/chunk execution workflow. The bundled snippets are scoped separately for Quarto and Markdown.

GitHub Copilot is selected as the edit-prediction provider. Predictions are disabled for ordinary Markdown (including `.Rmd`), YAML, and text files while remaining enabled for `.qmd` and programming languages. Sign in to GitHub from Zed when prompted.

Remote SSH and Dev Containers use Zed's native remote project flow. No VS Code Remote settings are copied; Zed reads SSH configuration through the system `ssh` command, and Dev Containers use each project's existing `.devcontainer/devcontainer.json`.

# Platform Support

Supports macOS (Darwin) and Ubuntu with platform-specific dependency scripts.

# Sync Excludes

- `scripts/.sync/mini-rsync.excludes`: exclude list for `push-mini` / `pull-mini` / `push-ms` / `pull-ms`
- `scripts/.sync/air-archives.include`: allowlist for `pull-mini-archives` subset sync from `mini/4-Archives` to `Air/4-Archives`
- `scripts/.sync/vault-rsync.excludes`: exclude list for `push-vault-backup` / `pull-vault-backup`
- `scripts/.sync/gdrive-rclone.excludes`: exclude list for `gdrive-*` commands

# Homebrew

Homebrew mirror at [tsinghua uni](https://mirror.tuna.tsinghua.edu.cn/help/homebrew/)

# SSH Configuration (private)

- <https://github.com/mattocci27/dotssh>

# Zotero

- <https://github.com/retorquere/zotero-better-bibtex>

- <https://github.com/jlegewie/zotfile>
