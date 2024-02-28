#!/bin/bash
# https://github.com/numToStr/dotfiles/blob/master/scripts/.dotscripts/install
set -e

# Moving two directory upwards to the root of the dotfiles
# from the scripts/ directory where this script
#cd "$(dirname "$0")/../"

export DOTFILES=$(pwd -P)
TARGET=$HOME
rm -f "${TARGET}/.DS_Store"
rm -rf $HOME/.config/nvim/lua/custom 

# List of packages that has to installed via `stow`
DOTFILES_DIRS=$(ls -d $DOTFILES/*/ | grep -v tests \
  | grep -v deps | grep -v fonts | awk -F "/" '{ print $(NF-1) }')

for F in $DOTFILES_DIRS ; do
    echo "~ Installing :: $F"

    # Remove previous links
    # NOTE: `stow` issues warning when working with absolute paths, so for now I am ignoring it
    # GHI: https://github.com/aspiers/stow/issues/65
    stow -D --dotfiles --dir $DOTFILES --target $TARGET $F 2>/dev/null

    # Installed new links
    stow --dotfiles --dir $DOTFILES --target $TARGET $F
done

# VSCODE config is in Library for mac
distro=$(uname)

if [ $distro = "Darwin" ]; then
  ln -snf ${DOTFILES}/Code/.config/Code/User/snippets/* ${HOME}/Library/Application\ Support/Code/User/snippets/
  ln -snf ${DOTFILES}/Code/.config/Code/User/*.json ${HOME}/Library/Application\ Support/Code/User/
  cp ${DOTFILES}/R/.R/Makevars-Darwin $HOME/.R/Makevars
elif [ $distro = "Linux" ]; then
  cp ${DOTFILES}/R/.R/Makevars-Linux $HOME/.R/Makevars
fi

echo "stow done"
