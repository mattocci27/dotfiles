#!/bin/sh
while read list
do
  if [ $list = "r" ]; then
    brew install r --with-openblas
  else 
    brew install $list
  fi
done < brewlist
