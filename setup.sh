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
if [ ! $distro == "Darwin" ]; then
  distro=`lsb_release -si`
fi

echo "Set up for $distro"

if [ ! -f "dependencies-${distro}" ]; then
#elif [ ! $(uname) == "Darwin" ]; then
  echo "Could not find file with dependencies for distro ${distro}. Aborting."
  exit 2
fi


ask "Update Mirrors for Manjaro?" Y && {
  sudo pacman-mirrors --country Japan,China,United_States
  sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
}

ask "Install packages?" Y && sh ./dependencies-${distro}

ask "Make dir for symlink?" Y && ./link_files.sh mkdir

ask "Install symlink?" Y && ./link_files.sh links

if [ $(uname) == "Darwin" ]; then
  ask "Install simlink for Code?" && {
    ln -snf ${DOT_DIRECTORY}/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -snf ${DOT_DIRECTORY}/.config/Code/User/keybindigs.json ~/Library/Application\ Support/Code/User/keybindigs.json
  }
fi

ask "Install font?" Y && {
  git clone https://github.com/ryanoasis/nerd-fonts ~/nerd-fonts
  cd ~/nerd-fonts
  chmod 755 font-patcher
  cd
  cd ${DOT_DIRECTORY}

  if [ ! $(uname) == "Darwin" ]; then
    sudo cp -rf ./fonts/Cousine/* ~/Library/Fonts
    fc-cache -vf
  elif [ ! $(uname) == "Linux" ]; then
    sudo cp -rf ./fonts/Cousine /usr/share/fonts/Cousine
  fi
}

ask "Install Atom stuffs?" Y && {
  while read list
  do
    apm install $list
  done < .atom/packages.txt
}

ask "Install R stuffs?" Y && {
  sh ./makevars.sh
  sudo pip3 install -U radian
  #sh ./Rpkg.sh install
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
