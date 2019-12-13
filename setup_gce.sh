#!/bin/sh
set -e
DOT_DIRECTORY="${HOME}/dotfiles"

OVERWRITE=true

mk_dirs(){
  array=`ls -aR | grep "^\./\." | grep -v git | sed 's/:$//g' | sed 's/^\.\///g'`
  for dir in $array
  do
    mkdir ${HOME}/${dir}
  done
}

mk_dirs

link_files() {
  array=`find | grep "^\./\." | grep -v git | grep -v ssh | sed 's/^\.\///g'`
  for f in $array
  do
    [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ] && rm -rf ${HOME}/${f}
    if [ ! -e ${HOME}/${f} ]; then
      ln -snf ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

link_files

# After .vim has been symlinked!
# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## zsh-plug manager
echo "Installing zsh-plug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
