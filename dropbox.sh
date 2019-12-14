#!/bin/sh

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  link
  setup
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

# Installation and settings
link(){
  cd && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
  ${HOME}/.dropbox-dist/dropboxd

  # download script
  mkdir -p ${HOME}/bin
  wget -O ${HOME}/bin/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py" 

  # permission
  Chmod 755 ${HOME}/bin/dropbox.py

  ${HOME}/bin/dropbox.py start

  echo "alias dropbox='${HOME}/bin/dropbox.py'" >> ${HOME}/.zshrc
  echo "alias dropbox='${HOME}/bin/dropbox.py'" >> ${HOME}/.bashrc
}

setup(){
  # list
  array=`ls ${HOME}/Dropbox`
  # exclude all 
  for f in $array
  do
    ${HOME}/bin/dropbox.py exclude add ${HOME}/Dropbox/${f}
  done 
}

command=$1
[ $# -gt 0 ] && shift

case $command in
  link)
    link
    ;;
  setup*)
    setup
    ;;
  *)
    usage
    ;;
esac
