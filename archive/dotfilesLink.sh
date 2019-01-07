#!/bin/sh
set -e
DOT_DIRECTORY="${HOME}/dotfiles"

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  deploy
Arguments:
  -f Overwrite 
  -h Print help
EOF
  exit 1
}

while getopts :fh opt; do
  case ${opt} in
    f)
      OVERWRITE=true
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

cd ${DOT_DIRECTORY}


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

  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

#link_files

link_files_atom() {
  for FILE in config.cson init.coffee keymap.cson snippets.cson styles.less packages.txt
  do 
    [ -n "${OVERWRITE}" -a -e ${HOME}/.atom/${FILE} ] && rm -f ${HOME}/.atom/${FILE}
    if [ ! -e ${HOME}/.atom/${FILE} ]; then
      ln -snfv ${DOT_DIRECTORY}/.atom/${FILE} ${HOME}/.atom/${FILE}
    fi
  done
  echo $(tput setaf 2)Deploy atom configs complete!. ✔︎$(tput sgr0)
}

#link_files_atom


command=$1
[ $# -gt 0 ] && shift

case $command in
  deploy)
    link_files
    link_files_atom
    ;;
  #init*)
  #  initialize
  #  ;;
  *)
    usage
    ;;
esac
