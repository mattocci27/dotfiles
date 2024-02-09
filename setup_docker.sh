#!/bin/sh
set -e
DOT_DIRECTORY="${HOME}/dotfiles"

OVERWRITE=true

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

echo "Installing tools..."
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update -y
sudo apt install -y xsel \
  build-essential \
  neovim \
  peco \
  fzf \
  zsh \
  tmux \
  tree \
  make \
  curl \
  wget \
  cargo \
  neofetch \
  ripgrep \
  zoxide \
  exa \
  htop \
  software-properties-common

sh ./scripts/.dotscripts/deploy.sh

echo "Installing Rust deps..."
cargo install bottom --locked

echo "Installing zsh-plug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

sudo cp -rf ./fonts/Cousine /usr/share/fonts/Cousine

# ask "Install Lnuarvim?" Y && {
#   echo "Installing lnuar-plug..."
#   LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
# }

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# if [ $distro != "Darwin" ]; then
# ask "Install apptainer?" Y && {
#   # go
#   wget -c https://go.dev/dl/go1.19.4.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

#   cd
#   export VERSION=1.1.4 # adjust this as necessary
#   wget https://ghproxy.com/https://github.com/apptainer/apptainer/releases/download/v${VERSION}/apptainer_${VERSION}_amd64.deb
#   sudo apt-get install -y ./apptainer_${VERSION}_amd64.deb
# }
# fi
