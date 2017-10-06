#!/bin/sh
while read list
  if [ $list = "r" ]; then
    brew install r --with-openblas
  else 
    do brew install $list
  fi
done < brewlist
