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

# make symbolic links
./dotfilesLink.sh

# install brew packages
./brew_install.sh
```

This keeps brew and brewlist up to date.
```shell
./brew.sh
```

Install R packages.
```shell
./Rpkg_install.sh
```


# Other setup
```shell
# tex
brew cask install basictex



m <- matrix(runif(1000^2), nrow = 1000)

microbenchmark(
  m %*% m,
  m * m
)
```
