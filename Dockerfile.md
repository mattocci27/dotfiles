```{sh}
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  wget \
  #chromium-browser \
  python-dev  \
  vim \
  git \
#  nodejs-legacy \
  #openjdk-9-jdk \
  zsh \
  tmux \
  clang 
  #\
  # For R
  #libxml2-dev \
  #libcurl4-openssl-dev  \
  #libssl-dev  \
  ## openblas
  #libopenblas-base \
  #libatlas3-base 
  ## TexLive
  #texlive-lang-cjk 

RUN chsh -s /usr/bin/zsh

# R
#RUN gpg --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
#  && gpg -a --export E084DAB9 | sudo apt-key add - \
#  && sudo su -c "echo 'deb https://cran.rstudio.com/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list"
#
#RUN apt-get update && apt-get install -y \
#  r-base r-base-dev \
#  gdebi-core 
#
#  #install RStudio-Server
#RUN  wget https://download2.rstudio.org/rstudio-server-1.1.453-amd64.deb \
#  && sudo gdebi rstudio-server-1.1.453-amd64.deb \
#  && rm rstudio-server-1.1.453-amd64.deb 
#
#  #install shiny and shiny-server
#RUN  R -e "install.packages('shiny', repos='http://cran.rstudio.com/')" \
#  && wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb \
#  && sudo gdebi shiny-server-1.5.7.907-amd64.deb \
#  && rm shiny-server-1.5.7.907-amd64.deb \
#  
#  #add user(s)
#  && sudo useradd mattocci


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

docker run --rm -i -t --net host -e DISPLAY=$DISPLAY \
    -v $HOME/.Xauthority:/root/.Xauthority:rw \
    mattocci/r-base /bin/bash

xhost +local:

docker run --rm -i -t -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    mattocci/r-base /bin/bash

apt-get update && apt-get install -y x11-apps

docker run --rm -it \
    --user=$(id -u):$(id -g) \  # ホスト側のUIDとGIDでコンテナを起動
   # $(for i in $(id -G); do echo -n "--group-add "$i; done) \  # 所属しているグループを全て設定
    --env=DISPLAY=$DISPLAY \  # ホスト側のDISPLAYを設定
    --env=QT_X11_NO_MITSHM=1 \  # X errorを抑える
    --workdir="/home/$USER" \  # 初期ディレクトリをホストユーザーのホームに設定
    --volume="/home/$USER:/home/$USER" \  # ホストユーザーホームをマウント
    --volume="/etc/group:/etc/group:ro" \  # 以下4つはホスト側のユーザー情報をそのまま使うための設定
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \  # ホスト側のXを使う
    mattocci/r-base \  # Dockerコンテナを指定
    rqt  # 実行コマンドを指定




```
