#!/bin/sh
brew update

brew upgrade

# update file list
brew list > brewlist

# delete old apps
brew cleanup

# update packages.list
apm upgrade --no-confirm
apm list --installed --bare > ~/dotfiles/.atom/packages.txt
