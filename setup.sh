#!/usr/bin/env bash
set -euo pipefail

DOT_DIRECTORY="${HOME}/dotfiles"

if [[ ! -e "${DOT_DIRECTORY}/$(basename "$0")" ]]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi

# ------------------------------------------------------------------
# Determine OS / distro
# ------------------------------------------------------------------
os="$(uname -s)"
distro="$os"

if [[ "$os" == "Linux" ]]; then
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

dep_file="./deps/dependencies-${distro}"

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
  echo "5) Install Python stuffs"
  echo "6) Install R deps"
  echo "7) Install NvChad"
  echo "8) Install tmux plugin manager"
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
      install_nvchad
      ;;
    8)
      install_tpm
      ;;
    *)
      echo "Invalid option. Please type a number from 0 to 8."
      exit 1
      ;;
  esac
}

setup_mirrors() {
  case "$distro" in
    manjaro)
      sudo pacman-mirrors --country Japan,China,United_States
      sudo pacman-mirrors --fasttrack
      sudo pacman -Syyu
      ;;
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
  bash "./scripts/.dotscripts/deploy.sh"
}

install_rust_deps() {
  cargo install dutree || true
  cargo install bottom zoxide --locked || true
}

install_fonts() {
  mkdir -p ./fonts/Cousine

  font_urls=(
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Regular/CousineNerdFont-Regular.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Bold/CousineNerdFont-Bold.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Italic/CousineNerdFont-Italic.ttf"
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/BoldItalic/CousineNerdFont-BoldItalic.ttf"
  )

  for url in "${font_urls[@]}"; do
    wget -P ./fonts/Cousine "$url"
  done

  if [[ "$os" == "Darwin" ]]; then
    mkdir -p "$HOME/Library/Fonts"
    cp -f ./fonts/Cousine/* "$HOME/Library/Fonts/"
  elif [[ "$os" == "Linux" ]]; then
    sudo mkdir -p /usr/share/fonts/Cousine
    sudo cp -f ./fonts/Cousine/* /usr/share/fonts/Cousine/
    fc-cache -vf
  fi
}

install_python_stuff() {
  if ! command -v pyenv >/dev/null 2>&1; then
    curl -fsSL https://pyenv.run | bash
  fi

  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"

  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    pyenv install -s 3.12.5
    pyenv global 3.12.5
    python -m pip install --upgrade pip
    python -m pip install -U radian pynvim
  else
    echo "pyenv installation seems incomplete. Restart shell and retry."
    exit 1
  fi
}

install_r_deps() {
  Rscript -e "install.packages(c('littler', 'pak', 'pacman', 'tidyverse', 'vegan', 'renv'), dependencies = TRUE)"
}

install_nvchad() {
  if [[ -d "$HOME/.config/nvim" ]]; then
    echo "~/.config/nvim already exists. Skipping NvChad install."
  else
    echo "Installing NvChad..."
    git clone https://github.com/NvChad/NvChad "$HOME/.config/nvim" --depth 1
    echo "NvChad installed."
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
