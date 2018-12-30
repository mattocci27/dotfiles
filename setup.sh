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

dir=`pwd`
if [ ! -e "${DOT_DIRECTORY}/$(basename $0)" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

# fix for mac
distro=`lsb_release -si`
if [ ! -f "dependencies-${distro}" ]; then
#elif [ ! $(uname) == "Darwin" ]; then
  echo "Could not find file with dependencies for distro ${distro}. Aborting."
  exit 2
fi

ask "Install packages?" Y && sh ./dependencies-${distro}

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

ask "Install symlink?" Y && link_files
 
ask "Install Atom stuffs?" Y && {
  while read list
  do
    apm install $list
  done < .atom/packages
}

ask "Install R stuffs?" Y && {
  sh ./makevars.sh
  sudo pip install -U rtichoke
  sh ./Rpkg.sh install
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

#if [ ! -d "${HOME}/.vim/dein.vim" ]; then
#  echo "Installing dein.vim..."
#  echo "Please run :call dein#install() from vinit.coffee keymap.cson snippets.cson styles.less packages.txtnit.coffee keymap.cson snippets.cson styles.less packages.txtm after this!"
#  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/deinvim-installer.sh
#  sh /tmp/deinvim-installer.sh ${HOME}/.vim/dein.vim
#fi

