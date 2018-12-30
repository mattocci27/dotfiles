#!/usr/bin/env bash
set -e

# Foundamental tools
sudo pacman -Ssy

sudo pacman -S base-devel wget

echo "Installing yay..."
if ! command -v "yay" >/dev/null 2>&1; then
    cd $HOME
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd -
fi

echo "Installing Python dependencies..."
yay -S --noconfirm python \
  python-pip \
  python2-neovim \
  python-neovim \

echo "Installing tools..."
yay -S --noconfirm xsel \
  peco \
  zsh \
  clang \
  gcc-fortran \
  ruby \
  rubygems \
  ruby-rdoc \
  rofi \
  compton \
  i3lock \
  i3blocks-gaps-git \
  i3status-git \
  gsimplecal \
  thunderbird \
  thunderbird-enigmail-bin \
  feh \
  imagemagick \
  openmpi \
  openblas \
  fontforge \
  google-chrome \
  brave \
  atom \
  apm \
  albert \
  blueman

echo "Installing Dropbox..."
yay -S --noconfirm dropbox \
  dropbox-nautilus-dropbox

echo "Installing latex..."
yay -S --noconfirm texlive-langjapanese \
  texlive-langchinse \
  ghostscript \
  evince \
  poppler-data \
  pandoc \
  pandoc-citeproc \
  pandoc-crossref \
  texlive-most

echo "Installing R depenencies..."
yay -S --noconfirm r \
sudo pip install -U rtichoke

echo "Installing Julia depenencies..."
yay -S --noconfirm julia

##  makevars file
bash ./makevars.sh
# install packages in .R/Rpkgs_list.txt
#./Rpkg.sh install

# R
yes | sudo pacman -S openblas
yes | sudo pacman -S r
sudo pip install -U rtichoke

##  makevars file
bash ./makevars.sh

# install packages in .R/Rpkgs_list.txt
./Rpkg.sh install

# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# other
yes | sudo yaourt -S atom
yes | sudo yaourt -S albert
yes | sudo yaourt -S google-chrome
yes | sudo yaourt -S dropbox
#yes | sudo yaourt -S spotify


# font
git clone https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
chmod 755 font-patcher

fontforge -script ./font-patcher /user/share/fonts/Cousine/Cousine-Regular.ttf --fontawesome --fontlinux --octicons --pomicons --powerline --powerlineextra

cd ..

# make symbolic links
cd dotfiles
./dotfilesLink.sh deploy

DOT_DIRECTORY="${HOME}/dotfiles"
#ln -snfv ${DOT_DIRECTORY}/alacritty.yml ${HOME}/.config/alacritty/.alacritty.yml

ln -snfv ${DOT_DIRECTORY}/.i3 ${HOME}/.i3
ln -snfv ${DOT_DIRECTORY}/.Xresources ${HOME}/.Xresources

# display
# for full HD

xrandr --dpi 276 --fb 5440x3060 \
  --output HDMI1 --scale 1.5x1.5 \
  --output eDP1 --panning 2560x1440+0+1620

cat $XDG_ONFIG_HOME/alacritty/alacritty.yml
cat $XDG_CONFIG_HOME/alacritty.yml
cat $HOME/.config/alacritty/alacritty.yml
cat $HOME/.alacritty.yml

