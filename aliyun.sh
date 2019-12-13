#!/bin/sh

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
  # debian dependecies for R
  sudo apt install dirmngr --install-recommends
  sudo apt install software-properties-common
  sudo apt install apt-transport-https

  sudo apt update
  sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'
  sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/debian stretch-cran35/'


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

  #### For R
  sudo apt -y install libxml2-dev
  sudo apt -y install libcurl4-openssl-dev 
  sudo apt -y install libssl-dev 
  # openblas
  sudo apt -y install libopenblas-base
  sudo apt -y install libatlas3-base
  # R
  sudo apt -y install r-base r-base-dev
  sudo apt -y install gdebi-core

  # port
  sudo apt -y install ufw
  sudo ufw enable
  sudo ufw allow 80/tcp
  sudo ufw allow 22/tcp
  # TexLive
  #sudo apt -y install texlive-lang-cjk

  # Git
  sudo -i -u "${USERNAME}" git config --global user.name "Masatoshi Katabuchi"
  sudo -i -u "${USERNAME}" git config --global user.email "mattocci27@gmail.com"

  ### Python packages
  sudo apt -y install python-pip python-virtualenv python-numpy python-matplotlib

  ### pip packages
  sudo pip install django flask django-widget-tweaks django-ckeditor beautifulsoup4 requests classifier SymPy ipython

  sudo apt -y install neovim

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

  # Kryptonite CLI for key management
  #curl https://krypt.co/kr | sh

  #install RStudio-Server
  #j wwget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb
  #j wsudo gdebi rstudio-server-1.1.423-amd64.deb
  #j wrm rstudio-server-1.1.423-amd64.deb

  #install shiny and shiny-server
  #R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
  #wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb
  #sudo gdebi shiny-server-1.5.6.875-amd64.deb
  #rm shiny-server-1.5.6.875-amd64.deb

  #add user(s)
  #sudo useradd mattocci
  #echo username:password | chpasswd 

  # install dropox 
  #cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
  #~/.dropbox-dist/dropboxd

  # download script
  #mkdir -p ~/bin
  #wget -O ~/bin/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py" 

  # permission
  #chmod 755 ~/bin/dropbox.py

  ## list
  #ls ~/Dropbox > ~/dropbox.txt

  ## exclude all 
  #while read list
  #  do
  #    ~/bin/dropbox.py exclude add ~/Dropbox/$list
  #done < ~/dropbox.txt

}

#install_Rstudio(){
#  #install RStudio-Server
#  wget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb
#  sudo gdebi rstudio-server-1.1.423-amd64.deb
#  rm rstudio-server-1.1.423-amd64.deb
#
#  #install shiny and shiny-server
#  R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
#  wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb
#  sudo gdebi shiny-server-1.5.6.875-amd64.deb
#  rm shiny-server-1.5.6.875-amd64.deb
#
#  #add user(s)
#  sudo useradd mattocci
#  #echo username:password | chpasswd 
#}
#
#install_dropbox(){
#  # install dropox 
#  cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#  ~/.dropbox-dist/dropboxd
#
#  # download script
#  mkdir -p ~/bin
#  wget -O ~/bin/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py" 
#
#  # permission
#  Chmod 755 ~/bin/dropbox.py
#
#  # list
#  ls ~/Dropbox > dropbox.txt
#
#  # exclude all 
#  while read list
#    do
#      ~/bin/dropbox.py exclude add ~/Dropbox/$list
#  done < dropbox.txt
#}


# Update on each startup except the first time
update()
{
  sudo apt update
  sudo apt upgrade
  #kr upgrade
}

command=$1
[ $# -gt 0 ] && shift

case $command in
  setup)
    setup
    ;;
  update*)
    update
    ;;
  *)
    usage
    ;;
esac
