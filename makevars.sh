#!/bin/sh
set -e

MAKEVARS="CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function"

# for Linux
if [ "$(uname)" == 'Linux' ]; then
  MAKEVARS="${MAKEVARS} -DBOOST_PHOENIX_NO_VARIADIC_EXPRESSION\nCC=clang\nCXX=clang++"
# additional for Mac
elif [ "$(uname)" == 'Darwin' ]; then
  MAKEVARS="${MAKEVARS}\nCC=clang\nCXX=clang++ -arch x86_64 -ftemplate-depth-256"
fi

# create Makevars in .R
if ! [ -e $HOME/.R ]; then
  mkdir $HOME/.R
fi

# need echo -e to insert new lines
if ! [ -e $HOME/.R/Makevars ]; then
  echo -e $MAKEVARS > $HOME/.R/Makevars
fi
