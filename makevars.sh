#!/bin/sh

# for linux
MAKEVARS="CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function"

# additional for mac
if [ "$(uname)" == 'Darwin' ]; then
  MAKEVARS="${MAKEVARS}
  \nCC=clang
  \nCXX=clang++ -arch x86_64 -ftemplate-depth-256"
fi


# create Makevars in .R
if ! [ -e $HOME/.R ]; then
  mkdir $HOME/.R
fi

if ! [ -e $HOME/.R/Makevars ]; then
  echo $MAKEVARS > $HOME/.R/Makevars
  echo $MAKEVARS >  moge.txt
  $HOME/.R/Makevars
fi

