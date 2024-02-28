#!/bin/bash
set -e

DOT_DIRECTORY="${HOME}/dotfiles"

if [ ! -e "${DOT_DIRECTORY}/$(basename "$0")" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi

# Determine OS Distribution
distro=$(uname -s)
if [ "$distro" = "Linux" ]; then
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    # Remove spaces from $NAME
    distro="${NAME// /}"
  elif type lsb_release >/dev/null 2>&1; then
    distro=$(lsb_release -si)
  else
    echo "Cannot determine Linux distribution"
    exit 1
  fi
fi

if [ ! -f "./deps/dependencies-${distro}" ]; then
  echo "Could not find file with dependencies for distro ${distro}. Aborting."
  exit 2
fi

# Menu function for selecting operations
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

  case $menu_num in
    0)
      case $distro in
        ManjaroLinux)
          sudo pacman-mirrors --country Japan,China,United_States
          sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
          ;;
        Ubuntu)
          sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
          CHINESE_MIRROR="https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/"
          sudo sed -i "s|http://ports.ubuntu.com/ubuntu-ports/|$CHINESE_MIRROR|g" /etc/apt/sources.list
          ;;
        *)
          echo "No specific actions defined for $distro"
          ;;
      esac
      ;;
    1)
      sh "./deps/dependencies-${distro}"
      ;;
    2)
      sh "./scripts/.dotscripts/deploy.sh"
      ;;
    3)
      cargo install dutree
      cargo install bottom zoxide --locked
      ;;
    4)
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
      Which one is better?
      if [ "$(uname)" = "Darwin" ]; then
        sudo cp -rf ./fonts/Cousine/* ~/Library/Fonts
      elif [ "$(uname)" = "Linux" ]; then
        sudo cp -rf ./fonts/Cousine /usr/share/fonts/Cousine
        fc-cache -vf
      fi
      ;;
    5)
      if ! command -v pyenv &> /dev/null; then
        curl https://pyenv.run | bash
        pyenv install 3.12.2
        pyenv global 3.12.2
        pip install -U radian
        pip install pynvim
      else
        echo "pyenv is already installed."
      fi
      ;;
    6)
      if [ "$distro" != "Darwin" ]; then
        ln -sf /opt/homebrew/opt/openblas/lib/libblas.dylib /Library/Frameworks/R.framework/Resources/lib/libRblas.dylib
        ln -sf /opt/homebrew/opt/openblas/lib/liblapack.dylib /Library/Frameworks/R.framework/Resources/lib/libRlapack.dylib
      fi
      Rscript -e "install.packages(c('littler', 'pacman', 'tidyverse', 'vegan', 'renv'), dependencies = TRUE)"
      ;;
    7)
      echo "Installing NvChad..."
      git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
      ;;
    8)
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      ;;
    *)
      echo "Invalid option. Please type a number from 0 to 8."
      ;;
  esac
}

# Execute the menu function to start the script
menu
