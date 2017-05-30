#!/bin/sh
set -e
DOT_DIRECTORY="${HOME}/dotfiles"

cd ${DOT_DIRECTORY}

link_files() {
  for f in .??*
  do
    # Force remove the vim directory if it's already there
    [ -n "${OVERWRITE}" -a -e ${HOME}/${f} ] && rm -f ${HOME}/${f}
    if [ ! -e ${HOME}/${f} ]; then
      # If you have ignore files, add file/directory name here
      [[ ${f} = ".git" ]] && continue
      [[ ${f} = ".gitignore" ]] && continue
      [[ ${f} = ".ssh" ]] && continue
      ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
    fi
  done

  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

link_files

link_files_atom() {
  for FILE in config.cson init.coffee keymap.cson snippets.cson styles.less packages.txt
  do 
    rm -f ${HOME}/.atom/${FILE}
    if [ ! -e ${HOME}/.atom/${FILE} ]; then
      ln -snfv ${DOT_DIRECTORY}/.atom/${FILE} ${HOME}/.atom/${FILE}
    fi
  done
  echo $(tput setaf 2)Deploy atom configs complete!. ✔︎$(tput sgr0)
}

link_files_atom

