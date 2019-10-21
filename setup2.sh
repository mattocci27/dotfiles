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

link_files() {
  while read FILE
  do
    [ -n "${OVERWRITE}" -a -e ${HOME}/${FILE} ] && rm -f ${HOME}/${FILE}
    if [ ! -e ${HOME}/${FILE} ]; then
      ln -snf ${DOT_DIRECTORY}/${FILE} ${HOME}/${FILE}
    fi
 # done < link-${(uname)}
  done < link-$(uname)
  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}


ask "Make dir for symlink?" Y && {
  mkdir ~/.config
  mkdir ~/.config/Code
  mkdir ~/.config/Code/User
  mkdir ~/.config/alacritty
  mkdir ~/.config/nvim
  mkdir ~/.config/ranger
  mkdir ~/.config/i3
  mkdir ~/.config/polybar
  mkdir ~/.config/polybar/config
  mkdir ~/.config/i3blocks
  mkdir ~/.atom
}

ask "Install symlink?" Y && link_files

if [ $(uname) == "Darwin" ]; then
  ask "Install simlink for Code?" && {
    ln -snf ${DOT_DIRECTORY}/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -snf ${DOT_DIRECTORY}/.config/Code/User/keybindigs.json ~/Library/Application\ Support/Code/User/keybindigs.json
  }
fi


ask "Install R stuffs?" Y && {
  sh ./makevars.sh
  sudo pip3 install -U radian
  #sh ./Rpkg.sh install
}

# After .vim has been symlinked!
# vim-plug
ask "Install vim-plug for Neovim?" Y && {
  echo "Installing vim-plug..."
  echo "Please run :call PlugInstall() after this!"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

## zsh-plug manager
ask "Install zsh-plug ?" Y && {
  echo "Installing zsh-plug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}


ask "Install tmux plugin manager for tmux?" Y && {
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
}