#!/bin/sh
brew update

brew upgrade

# update file list
brew list > brewlist

# delete old apps
brew cleanup
