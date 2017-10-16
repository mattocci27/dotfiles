# dotfiles
This repository includes mainly configuration files.

# Requirement for macOS
- command line tools
- homebrew

```shell
# command line tools
sudo xcode-select --install

# homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

# Usage
Following commands will clone the repository and automatically make symbolic links. Some packages will be also installed via brew.
```shell
# clone this repo
git clone git://github.com/mattocci27/dotfiles.git ~/dotfiles

cd dotfiles

# install brew packages
./brew_install.sh

# make symbolic links
./dotfilesLink.sh deploy
```

This keeps brew and brewlist up to date.
```shell
./brew.sh
```

Install R packages.
```shell
# install packages in .R/Rpkgs_list.txt
./Rpkg.sh install

# update installed packages
./Rpkg.sh update
```

# Other setup
- setup [nerd-font](https://qiita.com/sizukutamago/items/2ba906ab3fa404eac02d)
- [Alacritty](https://github.com/jwilm/alacritty)
- [pyenv](https://qiita.com/crankcube@github/items/15f06b32ec56736fc43a)

```shell
# tex
brew cask install basictex
sudo tlmgr update --self
sudo tlmgr update --all
sudo tlmgr install titling framed inconsolata

# japanese
brew cask install google-japanese-ime

# vim plug-in manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

```
