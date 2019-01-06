# dotfiles
This repository includes mainly configuration files.

# Manjaro Linux

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
./brew.sh setup

# make symbolic links
./dotfilesLink.sh deploy

ln -snfv ~/dotfiles/init.vim ~/.config/nvim/init.vim
```

This keeps brew and brewlist up to date.
```shell
./brew.sh update
```

Install R packages.
```shell

# create makevars file
bash ./makevars.sh

# install packages in .R/Rpkgs_list.txt
./Rpkg.sh install

# update installed packages
./Rpkg.sh update

# Rtichoke
# install released version
pip install -U rtichoke
```

# Other setup
- setup [nerd-font](https://qiita.com/sizukutamago/items/2ba906ab3fa404eac02d)
- [Alacritty](https://github.com/jwilm/alacritty)
- [pyenv](https://qiita.com/crankcube@github/items/15f06b32ec56736fc43a)

```shell
CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib" \
PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2 \
pyenv install -v 3.7.0

pyenv install -l | grep '^3.7\.'

```

```shell
chmod 755 font-patcher

fontforge -script ./font-patcher ~/Library/Fonts/Cousine-Regular.ttf --fontawesome --fontlinux --octicons --pomicons --powerline --powerlineextra

cp -f ./Ricty\ Regular\ for\ Powerline\ Nerd\ Font\ Complete.ttf ~/Library/Fonts/
fc-cache -vf

```



```shell
# tex
brew cask install basictex
sudo tlmgr update --self
sudo tlmgr update --all

sudo tlmgr install collection-fontsrecommended \
  type1cm \
  titling \
  framed \
  inconsolata \
  latexdiff \
  biblatex \
  biber \
  bibtex8 \
  subfigure \
  dvipdfmx \
  multirow \
  lastpage \
  lipsum \
  titlesec \
  wrapfig \
  sidecap \
  standalone \
  preview

# japanese
brew cask install google-japanese-ime

# vim plug-in manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/cocopon/iceberg.vim.git ~/.vim/pack/themes/opt/iceberg
```
