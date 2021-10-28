#!/bin/sh
set -e

MAKEVARS="CXX14FLAGS=-O3 -mtune=native -Wno-unused-variable -Wno-unused-function"

# for Linux
if [ "$(uname)" == 'Linux' ]; then
  MAKEVARS="${MAKEVARS} \nCXX14FLAGS += -fPIC"
# additional for Mac
elif [ "$(uname)" == 'Darwin' ]; then
  MAKEVARS="${MAKEVARS}\nCC=clang -arch arm64\nCXX=clang++ -arch arm64 -ftemplate-depth-256 -std=gnu++11"
fi

# create Makevars in .R
if ! [ -e $HOME/.R ]; then
  mkdir $HOME/.R
fi

# need echo -e to insert new lines
if ! [ -e $HOME/.R/Makevars ]; then
  echo -e $MAKEVARS > $HOME/.R/Makevars
fi
