#!/bin/sh

ZONE=hogehoge.team
ZONENAME=hogehoge-team
USERNAME=mattocci

INITIALIZED_FLAG=".startup_script_initialized"

main()
{
  tell_my_ip_address_to_dns
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
setup()
{
  # Foundamental tools
  apt-get update
  apt-get install -y build-essential
  apt-get install -y chromium-browser

  # Kryptonite CLI for key management
  #curl https://krypt.co/kr | sh

  # for R
  sudo apt-get -y install libxml2-dev
  sudo apt-get -y install libcurl4-openssl-dev 
  sudo apt-get -y install libssl-dev 

  # open blas
  sudo apt-get -y install libopenblas-base
  sudo apt-get -y install libatlas3-base

  # Git
  sudo -i -u "${USERNAME}" git config --global user.name "Masatoshi Katabuchi"
  sudo -i -u "${USERNAME}" git config --global user.email "mattocci27@gmail.com"
}

# Update on each startup except the first time
update()
{
  apt-get update
  apt-get upgrade
  #kr upgrade
}

tell_my_ip_address_to_dns()
{
}

main
