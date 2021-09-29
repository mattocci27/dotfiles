FROM rocker/rstudio:4.1.1

ENV DEBIAN_FRONTEND noninteractive

COPY . /root/dotfiles