#!/bin/sh
set -e

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  setup
  update 
Arguments:
  -h Print help
EOF
  exit 1
}

while getopts :h opt; do
  case ${opt} in
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

setup() {
  while read list
  do
    if [ $list = "r" ]; then
      brew install r --with-openblas
    else 
      brew install $list
    fi
  done < brewlist
}


update() {
  brew update

  brew upgrade

  # update file list
  brew list > brewlist

  # delete old apps
  brew cleanup

  # update packages.list
  apm upgrade --no-confirm
  apm list --installed --bare > ~/dotfiles/.atom/packages.txt
}


command=$1
[ $# -gt 0 ] && shift

case $command in
  update)
    update
    ;;
  setup)
    setup
    ;;
  #init*)
  #  initialize
  #  ;;
  *)
    usage
    ;;
esac

