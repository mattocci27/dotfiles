#!/bin/sh

#ZONE=hogehoge.team
#ZONENAME=hogehoge-team
USERNAME=mattocci

INITIALIZED_FLAG=".startup_script_initialized"

main()
{
  #tell_my_ip_address_to_dns
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

# Installation and settings
setup(){
  # add rstudio URL 
  #sudo su -c "echo 'deb http://cran.rstudio.com/bin/linux/debian stretch-cran34/' >> /etc/apt/sources.list"
  # Foundamental tools
  sudo apt-get update && sudo apt-get install -y \
    build-essential \
    python-dev \
    git \
    zsh \
    tmux \
    vim \
    mosh


  # Git
  sudo -i -u "${USERNAME}" git config --global user.name "Masatoshi Katabuchi"
  sudo -i -u "${USERNAME}" git config --global user.email "mattocci27@gmail.com"

}


# Update on each startup except the first time
update()
{
  sudo apt-get update
  sudo apt-get upgrade
}

main
