#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
DOT_DIRECTORY="$SCRIPT_DIR"

if [[ ! -f "${DOT_DIRECTORY}/setup.sh" ]]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi

# ------------------------------------------------------------------
# Determine OS / distro
# ------------------------------------------------------------------
os=$(uname -s | tr '[:upper:]' '[:lower:]')
distro="$os"

if [[ "$os" == "linux" ]]; then
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    distro="${ID:-linux}"
  elif command -v lsb_release >/dev/null 2>&1; then
    distro="$(lsb_release -si | tr '[:upper:]' '[:lower:]')"
  else
    echo "Cannot determine Linux distribution"
    exit 1
  fi
fi

dep_file="${DOT_DIRECTORY}/deps/dependencies-${distro}"

if [[ ! -f "$dep_file" ]]; then
  echo "Could not find dependency file: ${dep_file}. Aborting."
  exit 2
fi

# ------------------------------------------------------------------
# Helper functions
# ------------------------------------------------------------------
menu() {
  echo "0) Setup mirrors"
  echo "1) Install packages"
  echo "2) Install symlinks using stow"
  echo "3) Install Rust deps"
  echo "4) Install font"
  echo "5) Install Python tools"
  echo "6) Install R deps"
  echo "7) Install tmux plugin manager"
  echo "8) Setup cloud symlinks (macOS only)"
  read -rp "Enter number: " menu_num

  case "$menu_num" in
  0)
    setup_mirrors
    ;;
  1)
    install_packages
    ;;
  2)
    install_symlinks
    ;;
  3)
    install_rust_deps
    ;;
  4)
    install_fonts
    ;;
  5)
    install_python_stuff
    ;;
  6)
    install_r_deps
    ;;
  7)
    install_tpm
    ;;
  8)
    setup_cloud_symlinks
    ;;
  *)
    echo "Invalid option. Please type a number from 0 to 8."
    exit 1
    ;;
  esac
}

setup_mirrors() {
  case "$distro" in
  ubuntu)
    # amd64 Ubuntu mirror setup
    if [[ -f /etc/apt/sources.list ]]; then
      sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
      CHINESE_MIRROR="https://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
      sudo sed -i "s|http://archive.ubuntu.com/ubuntu/|$CHINESE_MIRROR|g" /etc/apt/sources.list
      sudo sed -i "s|http://security.ubuntu.com/ubuntu/|$CHINESE_MIRROR|g" /etc/apt/sources.list
      echo "Updated /etc/apt/sources.list for Ubuntu amd64."
    else
      echo "/etc/apt/sources.list not found. Skipping mirror setup."
    fi
    ;;
  *)
    echo "No specific mirror actions defined for $distro"
    ;;
  esac
}

install_packages() {
  bash "$dep_file"
}

install_symlinks() {
  bash "${DOT_DIRECTORY}/scripts/.dotscripts/deploy.sh"
}

install_rust_deps() {
  cargo install dutree || true
  cargo install bottom zoxide --locked || true
}

install_fonts() {
  mkdir -p "${DOT_DIRECTORY}/fonts/Cousine"

  font_urls=(
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Regular/CousineNerdFont-Regular.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Bold/CousineNerdFont-Bold.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Italic/CousineNerdFont-Italic.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/BoldItalic/CousineNerdFont-BoldItalic.ttf"
  )

  for url in "${font_urls[@]}"; do
    wget -P "${DOT_DIRECTORY}/fonts/Cousine" "$url"
  done

  if [[ "$os" == "darwin" ]]; then
    mkdir -p "$HOME/Library/Fonts"
    cp -f "${DOT_DIRECTORY}/fonts/Cousine/"* "$HOME/Library/Fonts/"
  elif [[ "$os" == "linux" ]]; then
    sudo mkdir -p /usr/share/fonts/Cousine
    sudo cp -f "${DOT_DIRECTORY}/fonts/Cousine/"* /usr/share/fonts/Cousine/
    fc-cache -vf
  fi
}

install_python_stuff() {
  if ! command -v python3 >/dev/null 2>&1; then
    echo "python3 is not installed. Run package installation first."
    exit 1
  fi

  if ! command -v pipx >/dev/null 2>&1; then
    if [[ "$os" == "darwin" ]] && command -v brew >/dev/null 2>&1; then
      brew install pipx
    else
      echo "pipx is not installed. Install it first, then rerun this step."
      exit 1
    fi
  fi

  python3 -m pip install --user --upgrade pip pynvim
  pipx ensurepath
  pipx install --force radian
}

install_r_deps() {
  Rscript -e "install.packages(c('littler', 'pak', 'pacman', 'tidyverse', 'vegan', 'renv'), dependencies = TRUE)"
}

setup_cloud_symlinks() {
  if [[ "$os" != "darwin" ]]; then
    echo "Cloud symlinks setup is macOS only. Skipping."
    return
  fi

  mkdir -p "$HOME/Cloud"

  local gdrive="$HOME/Library/CloudStorage/GoogleDrive-mattocci27@gmail.com/My Drive"
  if [[ -d "$gdrive" ]]; then
    ln -sfn "$gdrive" "$HOME/Cloud/GDrive"
    echo "Linked GDrive -> ~/Cloud/GDrive"
  else
    echo "Google Drive not found at: $gdrive"
  fi

  local dropbox="$HOME/Library/CloudStorage/Dropbox"
  if [[ -d "$dropbox" ]]; then
    ln -sfn "$dropbox" "$HOME/Cloud/Dropbox"
    echo "Linked Dropbox -> ~/Cloud/Dropbox"
  else
    echo "Dropbox not found at: $dropbox"
  fi
}

install_tpm() {
  if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "tmux plugin manager already installed."
  else
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi
}

menu
