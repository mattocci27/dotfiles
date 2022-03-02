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

# fix for mac
distro=$(uname)

if [ $distro != "Darwin" ]; then
  distro=`lsb_release -si`
fi

echo "Set up for $distro"

if [ ! -f "./deps/dependencies-${distro}" ]; then
  echo "Could not find file with dependencies for distro ${distro}. Aborting."
  exit 2
fi


if [ $distro = "Manjaro" ]; then
ask "Update Mirrors for Manjaro?" Y && {
  sudo pacman-mirrors --country Japan,China,United_States
  sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
}
fi

if [ $distro = "Ubuntu" ]; then
ask "Use Chinese Mirrors for Ubuntu?" Y && {
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
  sudo sed -i.bak -e "s%http://archive.ubuntu.com/%https://mirrors.tuna.tsinghua.edu.cn/%g" /etc/apt/sources.list
  sudo sed -i.bak -e "s%http://security.ubuntu.com/%https://mirrors.tuna.tsinghua.edu.cn/%g" /etc/apt/sources.list
  }
fi

ask "Install packages?" Y && sh ./deps/dependencies-${distro}

ask "Install symlinks using stow?" Y && sh ./scripts/deploy.sh

ask "Install font?" Y && {
  #git clone https://github.com/ryanoasis/nerd-fonts ~/nerd-fonts
  #cd ~/nerd-fonts
  #chmod 755 font-patcher
  #cd
  #cd ${DOT_DIRECTORY}

  if [ $(uname) == "Darwin" ]; then
    sudo cp -rf ./fonts/Cousine/* ~/Library/Fonts
    fc-cache -vf
  elif [ $(uname) == "Linux" ]; then
    sudo cp -rf ./fonts/Cousine /usr/share/fonts/Cousine
  fi
}

ask "Install Python stuffs? (run this after pyenv)" Y && {
  pip install -U radian
  pip install pynvim
}

ask "Install R deps?" Y && {
  Rscript -e "install.packages(c('littler', 'pacman'), dependencies = TRUE, error = TRUE)"
}

ask "Install R packages?" Y && {
  bath .scripts/Rpkg.sh
}


ask "Install Lnuarvim?" Y && {
  echo "Installing lnuar-plug..."
  bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
}

# After .vim has been symlinked!
# vim-plug
ask "Install vim-plug for Neovim?" Y && {
  echo "Installing vim-plug..."
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim +PlugInstall +qall
}

## zsh-plug manager
ask "Install zsh-plug ?" Y && {
  echo "Installing zsh-plug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}


ask "Install tmux plugin manager for tmux?" Y && {
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
}


ask "Install singularity?" Y && {
  # go
  wget -c https://dl.google.com/go/go1.16.3.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local

  cd
  export VERSION=3.8.3 # adjust this as necessary
  wget https://github.com/hpcng/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
  tar -xzf singularity-${VERSION}.tar.gz
  cd singularity-${VERSION}

  ./mconfig && \
      make -C builddir && \
      sudo make -C builddir install
}
