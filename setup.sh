#!/bin/sh
set -e
DOT_DIRECTORY="${HOME}/dotfiles"

OVERWRITE=true

ask() {
  # http://djm.me/ask
  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
       REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

if [ ! -e "${DOT_DIRECTORY}/$(basename $0)" ]; then
  echo "Script not called from within repository directory. Aborting."
  exit 2
fi
dir="${dir}/.."

# fix for mac
distro=$(uname)

if [ $distro != "Darwin" ]; then
  distro=`lsb_release -si`
fi

echo "Set up for $distro"

if [ ! -f "./deps/dependencies-${distro}" ]; then
  echo "Could not find file with dependencies for distro ${distro}. Aborting."
  exit 2
fi


if [ $distro = "Manjaro" ]; then
ask "Update Mirrors for Manjaro?" Y && {
  sudo pacman-mirrors --country Japan,China,United_States
  sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
}
fi

if [ $distro = "Ubuntu" ]; then
ask "Use Chinese Mirrors for Ubuntu?" Y && {
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
  sudo sed -i.bak -e "s%http://archive.ubuntu.com/%https://mirrors.tuna.tsinghua.edu.cn/%g" /etc/apt/sources.list
  sudo sed -i.bak -e "s%http://security.ubuntu.com/%https://mirrors.tuna.tsinghua.edu.cn/%g" /etc/apt/sources.list
  }
fi

ask "Install packages?" Y && sh ./deps/dependencies-${distro}

ask "Make dir for symlink?" Y && ./scripts/link_files.sh mkdir

ask "Install symlink?" Y && ./scripts/link_files.sh links

if [ $(uname) == "Darwin" ]; then
  ask "Install simlink for Code?" && {
    ln -snf ${DOT_DIRECTORY}/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -snf ${DOT_DIRECTORY}/.config/Code/User/keybindigs.json ~/Library/Application\ Support/Code/User/keybindigs.json
  }
fi

ask "Install font?" Y && {
  #git clone https://github.com/ryanoasis/nerd-fonts ~/nerd-fonts
  cd ~/nerd-fonts
  chmod 755 font-patcher
  cd
  cd ${DOT_DIRECTORY}

  if [ $(uname) == "Darwin" ]; then
    sudo cp -rf ./fonts/Cousine/* ~/Library/Fonts
    fc-cache -vf
  elif [ $(uname) == "Linux" ]; then
    sudo cp -rf ./fonts/Cousine /usr/share/fonts/Cousine
  fi
}

ask "Install Atom stuffs?" Y && {
  while read list
  do
    apm install $list
  done < .atom/packages.txt
}

ask "Install R and python stuffs?" Y && {
  sh ./scripts/makevars.sh
  sudo pip3 install -U radian
  sudo pip3 install pynvim
  #sh ./Rpkg.sh install
  Rscript -e "install.packages(c('littler', 'pacman'), dependencies = TRUE, error = TRUE)"
	ln -s /usr/local/lib/R/4.0/site-library/littler/examples/install.r /usr/local/bin/install.r
	ln -s /usr/local/lib/R/4.0/site-library/littler/examples/install2.r /usr/local/bin/install2.r
	ln -s /usr/local/lib/R/4.0/site-library/littler/examples/installBioc.r /usr/local/bin/installBioc.r
	ln -s /usr/local/lib/R/4.0/site-library/littler/examples/installDeps.r /usr/local/bin/installDeps.r
	ln -s /usr/local/lib/R/4.0/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r
	ln -s /usr/local/lib/R/4.0/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r
}

ask "Install R packages?" Y && {

  Rscript -e "pacman::p_load(
    tidyverse)"

  Rscript -e "pacman::p_load(
    rstan)"

  Rscript -e "pacman::p_load(
    vegan)"

  Rscript -e "pacman::p_load(
      FD,
      FactoMineR,
      GGally,
      MuMIn,
      Rcpp,
      RcppEigen,
      RcppNumerical,
      adephylo,
      adespatial,
      blogdown,
      bookdown,
      caper,
      corrplot,
      cowplot,
      devtools,
      entropart,
      factoextra,
      furrr,
      ggrepel,
      ggthemes,
      hexbin,
      kableExtra,
      kfigr,
      languageserver,
      lme4,
      memisc,
      microbenchmark,
      mnormt,
      multcompView,
      mvtnorm,
      nlme,
      pander,
      phytools,
      picante,
      png,
      provenance,
      rmarkdown,
      rstan,
      rstanarm,
      sads,
      shiny,
      smatr,
      snowfall,
      tictoc,
      tidyverse,
      vegan)"

}

# After .vim has been symlinked!
# vim-plug
ask "Install vim-plug for Neovim?" Y && {
  echo "Installing vim-plug..."
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim +PlugInstall +qall
}

## zsh-plug manager
ask "Install zsh-plug ?" Y && {
  echo "Installing zsh-plug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}


ask "Install tmux plugin manager for tmux?" Y && {
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
}
