#!/bin/sh
set -e
DOT_DIRECTORY="${HOME}/dotfiles"
OVERWRITE=true

# List of packages that has to installed via `stow`
DOTFILES_DIRS=$(ls -d $DOT_DIRECTORY/*/ | grep -v tests \
  | grep -v deps | grep -v fonts | awk -F "/" '{ print $(NF-1) }')

for F in $DOTFILES_DIRS ; do
    echo "~ Installing :: $F"
    # Installed new links
    stow --dotfiles --dir $DOT_DIRECTORY --target $HOME $F
done

chsh -s /usr/bin/zsh
