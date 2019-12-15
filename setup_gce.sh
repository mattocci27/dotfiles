#!/bin/sh
set -e
HOME="/home/${USERNAME}"
DOT_DIRECTORY="${HOME}/dotfiles"

OVERWRITE=true

mk_dirs(){
  array=`ls -aR | grep "^\./\." | grep -v git | sed 's/:$//g' | sed 's/^\.\///g'`
  for dir in $array
  do
    mkdir -p ${HOME}/${dir}
  done

  echo $(tput setaf 2)MMake dir complete!. ✔︎$(tput sgr0)
}

mk_dirs

link_files() {
  array=`find | grep "^\./\." | grep -v git | grep -v ssh | sed 's/^\.\///g'`
  for f in $array
  do
    # Force remove a dotfile if it's already there
    if [ -f ${f} ] &&
      [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ]; then
      rm -f ${HOME}/${f}
    fi
    if [ ! -e ${HOME}/${f} ]; then
      ln -snf ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}


link_files

# After .vim has been symlinked!
# vim-plug
curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## zsh-plug manager
echo "Installing zsh-plug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

git clone https://github.com/tmux-plugins/tpm ${HOME}/.config/tmux/plugins/tpm
