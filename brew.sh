#!/bin/sh
while read list
  do brew install $list
done < brewlist
