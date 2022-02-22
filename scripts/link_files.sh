#!/bin/sh

set -e

USERNAME=$(whoami)
distro=$(uname)

#if [ $distro == "Darwin" ]; then
#  HOME="/Users/${USERNAME}"
#else
#  HOME="/home/${USERNAME}"
#fi

DOT_DIRECTORY="${HOME}/dotfiles"

OVERWRITE=true

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  mkdir
  links
Arguments:
  -h Print help
EOF
  exit 1
}

while getopts :fh opt; do
  case ${opt} in
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

mk_dirs(){
  cd ${DOT_DIRECTORY}
  array=`ls -aR | grep "^\./\." | grep -v git | sed 's/:$//g' | sed 's/^\.\///g'`
  for dir in $array
  do
    mkdir -p ${HOME}/${dir}
  done

  echo $(tput setaf 2)Make dir for $USERNAME complete!. ✔︎$(tput sgr0)
}


link_files() {
  cd ${DOT_DIRECTORY}
  array=`find . -type f | grep "^\./\." | grep -v git | grep -v ssh | sed 's/^\.\///g'`
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

  ln -snf ${DOT_DIRECTORY}/.gitconfig ${HOME}/.gitconfig
  ln -snf ${DOT_DIRECTORY}/.gitignore_global ${HOME}/.gitignore_global
  echo $(tput setaf 2)Deploy dotfiles for $USERNAME complete!. ✔︎$(tput sgr0)
}


command=$1
[ $# -gt 0 ] && shift

case $command in
  links*)
    link_files
    ;;
  mkdir*)
    mk_dirs
    ;;
  *)
    usage
    ;;
esac
