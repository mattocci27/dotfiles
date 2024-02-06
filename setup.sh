#!/bin/sh
set -e
DOT_DIRECTORY="${HOME}/dotfiles"

OVERWRITE=true

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

if [ ! -e "${DOT_DIRECTORY}/$(basename $0)" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

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

echo "Set up for $distro"

# Use case statement for OS-specific actions
case $distro in
  "Manjaro Linux")
    ask "Update Mirrors for Manjaro?" Y && {
      sudo pacman-mirrors --country Japan,China,United_States
      sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
    }
    ;;
  "Ubuntu")
    ask "Use Chinese Mirrors for Ubuntu?" Y && {
      sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
      sudo sed -i.bak -e "s%http://archive.ubuntu.com/%https://mirrors.tuna.tsinghua.edu.cn/%g" /etc/apt/sources.list
      sudo sed -i.bak -e "s%http://security.ubuntu.com/%https://mirrors.tuna.tsinghua.edu.cn/%g" /etc/apt/sources.list
    }
    ;;
  *)
    echo "No specific actions defined for $distro"
    ;;
esac


ask "Install packages?" Y && sh ./deps/dependencies-${distro}

ask "Install symlinks using stow?" Y && sh ./scripts/.dotscripts/deploy.sh

ask "Install Rust deps ?" Y && {
  echo "Installing Rust deps..."
  cargo install ytop
}

## zsh-plug manager
ask "Install zsh-plug ?" Y && {
  echo "Installing zsh-plug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

ask "Install font?" Y && {
  if [ $(uname) == "Darwin" ]; then
    sudo cp -rf ./fonts/Cousine/* ~/Library/Fonts
    fc-cache -vf
  elif [ $(uname) == "Linux" ]; then
    sudo cp -rf ./fonts/Cousine /usr/share/fonts/Cousine
  fi
}

ask "Install Python stuffs? (run this after pyenv)" Y && {
  pyenv install 3.12.1
  pyenv global 3.12.1
  pip install -U radian
  pip install pynvim
}

ask "Install R deps?" Y && {
  if [ $distro != "Darwin" ]; then
    ln -sf /opt/homebrew/opt/openblas/lib/libblas.dylib /Library/Frameworks/R.framework/Resources/lib/libRblas.dylib

    ln -sf /opt/homebrew/opt/openblas/lib/liblapack.dylib /Library/Frameworks/R.framework/Resources/lib/libRlapack.dylib
  fi

  Rscript -e "install.packages(c('littler', 'pacman', 'tidyverse', 'vegan', 'renv'), dependencies = TRUE, error = TRUE)"
}

ask "Install Lnuarvim?" Y && {
  echo "Installing lnuar-plug..."
  LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
}

ask "Install tmux plugin manager for tmux?" Y && {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

if [ $distro != "Darwin" ]; then
ask "Install apptainer?" Y && {
  # go
  wget -c https://go.dev/dl/go1.19.4.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

  cd
  export VERSION=1.1.4 # adjust this as necessary
  wget https://ghproxy.com/https://github.com/apptainer/apptainer/releases/download/v${VERSION}/apptainer_${VERSION}_amd64.deb
  sudo apt-get install -y ./apptainer_${VERSION}_amd64.deb
}
fi
