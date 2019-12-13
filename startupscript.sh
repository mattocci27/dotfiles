#!/bin/sh

INITIALIZED_FLAG=".startup_script_initialized"

main()
{
  # tell_my_ip_address_to_dns
  if test -e $INITIALIZED_FLAG
  then
    # Startup Scripts
    update
  else
    # Only first time
    setup
    touch $INITIALIZED_FLAG
  fi
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
setup(){
  # Foundamental tools
  sudo apt update
  sudo apt -y install build-essential
  sudo apt -y install chromium-browser
  sudo apt -y install python-dev
  sudo apt -y install git
  sudo apt -y install nodejs-legacy
  sudo apt -y install openjdk-9-jdk
  sudo apt -y install zsh
  sudo apt -y install tmux
  sudo apt -y install clang
  sudo apt -y install mosh

  # Krypton CLI for key management
  curl https://krypt.co/kr | sh

  # docker
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88

  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable"

  sudo apt update
  sudo apt -y install docker-ce docker-ce-cli containerd.io
# sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

  # Git
  sudo -i -u "${USERNAME}" git config --global user.name "Masatoshi Katabuchi"
  sudo -i -u "${USERNAME}" git config --global user.email "mattocci27@gmail.com"

  git clone git://github.com/mattocci27/dotfiles.git ~/dotfiles

  ### Python packages
  sudo apt -y install python-pip python-virtualenv python-numpy python-matplotlib

  ### pip packages
  #sudo pip install django flask django-widget-tweaks django-ckeditor beautifulsoup4 requests classifier SymPy ipython

  sudo apt -y install neovim
}

# Update on each startup except the first time
update()
{
  sudo apt update
  sudo apt upgrade
  kr upgrade
}

main
