#!/bin/sh

MAKEVARS="CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function"

# for linux
if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  MAKEVARS="${MAKEVARS} -DBOOST_PHOENIX_NO_VARIADIC_EXPRESSION"
# additional for mac
elif [ "$(uname)" == 'Darwin' ]; then
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

