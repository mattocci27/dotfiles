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

link_files() {
  for f in .??*
  do
    # Force remove a dotfile if it's already there
    [[ -f ${f} ]] &&
      [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ] && rm -f ${HOME}/${f}
    if [ ! -e ${HOME}/${f} ]; then
      # If you have ignore files, add file/directory name here
      [[ ${f} = ".git" ]] && continue
      [[ ${f} = ".gitignore" ]] && continue
      [[ ${f} = ".ssh" ]] && continue
      ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  for d in .??*/
  do
    # Force remove a dotfile if it's already there
    [[ -f ${d} ]] &&
      [ -n "${OVERWRITE}" -a -e ${HOME}/${d} ] && rm -f ${HOME}/${d}
    if [ ! -e ${HOME}/${d} ]; then
      # If you have ignore files, add file/directory name here
      ln -snfv ${DOT_DIRECTORY}/${d} ${HOME}/${d}
    fi
  done
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
