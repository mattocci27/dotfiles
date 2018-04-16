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
  # add rstudio URL 
  #sudo su -c "echo 'deb http://cran.rstudio.com/bin/linux/debian stretch-cran34/' >> /etc/apt/sources.list"

  # need key for ubuntu
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
  gpg -a --export E084DAB9 | sudo apt-key add -

  sudo su -c "echo 'deb https://cran.rstudio.com/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list"

  # Foundamental tools

  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt-get update
  sudo apt-get -y install build-essential
  sudo apt-get -y install chromium-browser
  sudo apt-get -y install python-dev 
  sudo apt-get -y install git 
  sudo apt-get -y install nodejs-legacy
  sudo apt-get -y install openjdk-9-jdk
  sudo apt-get -y install zsh
  sudo apt-get -y install tmux
  sudo apt-get -y install clang
  sudo apt-get -y install vim

  #### For R
  sudo apt-get -y install libxml2-dev
  sudo apt-get -y install libcurl4-openssl-dev 
  sudo apt-get -y install libssl-dev 
  # openblas
  sudo apt-get -y install libopenblas-base
  sudo apt-get -y install libatlas3-base
  # R
  sudo apt-get -y install r-base r-base-dev
  sudo apt-get -y install gdebi-core

  # TexLive
  sudo apt-get -y install texlive-lang-cjk

  # Git
  sudo -i -u "${USERNAME}" git config --global user.name "Masatoshi Katabuchi"
  sudo -i -u "${USERNAME}" git config --global user.email "mattocci27@gmail.com"

  ### Python packages
  sudo apt-get -y install python-pip python-virtualenv python-numpy python-matplotlib

  ### pip packages
  sudo pip install django flask django-widget-tweaks django-ckeditor beautifulsoup4 requests classifier SymPy ipython

  # Kryptonite CLI for key management
  curl https://krypt.co/kr | sh

  #install RStudio-Server
  wget https://download2.rstudio.org/rstudio-server-1.1.423-amd64.deb
  sudo gdebi rstudio-server-1.1.423-amd64.deb
  rm rstudio-server-1.1.423-amd64.deb

  #install shiny and shiny-server
  R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
  wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb
  sudo gdebi shiny-server-1.5.6.875-amd64.deb
  rm shiny-server-1.5.6.875-amd64.deb

  #add user(s)
  sudo useradd mattocci
  #echo username:password | chpasswd 

  # install dropox 
  cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
  ~/.dropbox-dist/dropboxd

  # download script
  mkdir -p ~/bin
  wget -O ~/bin/dropbox.py "http://www.dropbox.com/download?dl=packages/dropbox.py" 

  # permission
  chmod 755 ~/bin/dropbox.py

  # list
  ls ~/Dropbox > ~/dropbox.txt

  # exclude all 
  while read list
    do
      ~/bin/dropbox.py exclude add ~/Dropbox/$list
  done < ~/dropbox.txt

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
  sudo apt-get update
  sudo apt-get upgrade
  kr upgrade
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
