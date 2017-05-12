# dotfiles
This repository includes mainly configuraiton files.

# Usage
Following commonds will clone the repository and automatically make symbolik links.Some packages will be also installed via brew.
```shell
% git clone git://github.com/mattocci27/dotfiles.git ~/dotfiles
% cd dotfiles
% ./dotfilesLink.sh
% ln -s brew.sh ~/brew.sh
% ln -s brewlist ~/brewlist
% ./brew_install.sh

```
This keeps brew and brewlist up to date.
```
% ./brew.sh
```
