# dotfiles
This repository includes mainly configuration files.

# Requirement for macOS
- command line tools

```shell
# command line tools
sudo xcode-select --install
```

# Usage (Mac and Manjaro Linux)

Following commands will clone the repository, install depenecies and make symbolic links.

```shell
# clone this repo
git clone git://github.com/mattocci27/dotfiles.git ~/dotfiles

cd dotfiles

# install dependencies and make symbolic links
sh setup.sh
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

