FROM ubuntu:18.04

MAINTAINER Masatoshi Katabuchi <mattocci27@gmail.com>

# Locales
ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8

RUN apt-get update \
  && apt-get install -y sudo \
  ca-certificates

# add sudo user
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -s /bin/bash mattocci && \
    echo 'mattocci:mogemoge' | chpasswd

RUN apt-get update && apt-get install -y \
  build-essential \
  git


# Common packages
RUN apt-get update && apt-get install -y \
  build-essential \
  apt-transport-https \
  curl \
  wget \
  #chromium-browser \
  python-dev  \
  vim \
  git \
  #nodejs-legacy \
  #openjdk-9-jdk \
  zsh \
  tmux \
  clang \
  #\
  # For R
  libxml2-dev \
  libcurl4-openssl-dev \
  libssl-dev \
  ## openblas
  libopenblas-base \
  libatlas3-base \
  ## TexLive
  texlive-lang-cjk \
  ## pandoc
  imagemagick \
  pandoc \
  pandoc-citeproc


RUN chsh -s /usr/bin/zsh

# Git
RUN sudo -i -u "${USERNAME}" git config --global user.name "Masatoshi Katabuchi" \
  && sudo -i -u "${USERNAME}" git config --global user.email "mattocci27@gmail.com"

RUN cd $HOME \
  && git clone https://github.com/mattocci27/dotfiles.git \
  && cd dotfiles \
  && sh ./dotfilesLink.sh deploy

# R
#RUN gpg --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
#  && gpg -a --export E084DAB9 | sudo apt-key add - \
#  && sudo su -c "echo 'deb https://cran.rstudio.com/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list"
#
RUN apt-get update && apt-get install -y \
  r-base r-base-dev \
  gdebi-core 
 
# install RStudio-Server
RUN  wget https://download2.rstudio.org/rstudio-server-1.1.453-amd64.deb \
  && sudo gdebi rstudio-server-1.1.453-amd64.deb \
  && rm rstudio-server-1.1.453-amd64.deb 

# install shiny and shiny-server
RUN  R -e "install.packages('shiny', repos='https://cran.rstudio.com/')" \
  && wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb \
  && sudo gdebi shiny-server-1.5.7.907-amd64.deb \
  && rm shiny-server-1.5.7.907-amd64.deb \
  #add user(s)
  && sudo useradd mattocci



# Install docker
#RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D &&\
#      echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list &&\
#      apt-get install -y apt-transport-https &&\
#      apt-get update &&\
#      apt-get install -y docker-engine
#RUN  curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.13.0/docker-compose-$(uname -s)-$(uname -m)" &&\
#     chmod +x /usr/local/bin/docker-compose
#RUN mkdir /$HOME/test
#WORKDIR /$HOME/test
