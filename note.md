
# chinese 
fcitx-sogoupinyin

pacman -S ttf-roboto noto-fonts noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts ttf-dejavu

# shortcut for multitasking (control panel)

dbus-send --session --dest=com.deepin.wm --print-reply /com/deepin/wm com.deepin.wm.PerformAction int32:1

# disable alt+space

gsettings list-recursively | grep activate-window-menu 

gsettings set org.gnome.desktop.wm.keybindings activate-window-menu []
gsettings set com.deepin.wrap.gnome.desktop.wm.keybindings activate-window-menu []

# QQ

https://www.lulinux.com/archives/1319

```

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

curl -L https://get.oh-my.fish | fish

fisher add oh-my-fish/plugin-peco

fisher add igalic/anicode
fisher add edc/bass
fisher add oh-my-fish/plugin-battery
fisher add oh-my-fish/theme-bobthefish
fisher add laughedelic/brew-completions

brew install terminal-notifier
fisher add franciscolourenco/done

fisher add Shadowigor/plugin-errno-grep

brew install fzy
fisher add gyakovlev/fish-fzy

brew install grc
fisher add oh-my-fish/plugin-grc

brew install jq
fisher add oh-my-fish/plugin-license

fisher add oh-my-fish/plugin-node-binpath

fisher add oh-my-fish/plugin-pj
set -U PROJECT_PATHS ~/Library/Projects

fisher add fisherman/shark
fisher add Markcial/upto
fisher add jethrokuan/z

```


```

ln -snf ${DOT_DIRECTORY}/${FILE} ${HOME}/${FILE}
ln -snf ~/dotfiles/.config/i3/config ~/.config/i3/config
ln -snf ~/dotfiles/.config/i3/monitor_detect.sh ~/.config/i3/monitor_detect.sh

ln -snf ~/dotfiles/.config/i3blocks/config ~/.config/i3blocks/config
ln -snf ~/dotfiles/.config/i3blocks/battery.sh ~/.config/i3blocks/battery.sh
ln -snf ~/dotfiles/.config/i3blocks/memory.py ~/.config/i3blocks/memory.py
ln -snf ~/dotfiles/.config/i3blocks/volume.sh ~/.config/i3blocks/volume.sh
ln -snf ~/dotfiles/.config/i3blocks/volume.sh ~/.config/i3blocks/volume.sh


ln -snf ~/dotfiles/.config/nvim/init_w.vim ~/.config/nvim/init_w.vim


ln -snf ~/Dropbox/seminar/20190809TropE/collapseoutput.js ~/Dropbox/mattocci27.github.io/assets/TropE-rmd/collapseoutput.js


ORI="/home/mattocci/Dropbox/seminar/20190809TropE"
DES="/home/mattocci/Dropbox/mattocci27.github.io/slide/TropE-rmd"

ln -snf ~/Dropbox/seminar/20190809TropE/fc2-fonts.css ~/Dropbox/mattocci27.github.io/slide/TropE-rmd/fc2-fonts.css
ln -snf ~/Dropbox/seminar/20190809TropE/fc2.css ~/Dropbox/mattocci27.github.io/slide/TropE-rmd/fc2.css

ln -snf ~/Dropbox/seminar/20190809TropE/rmd-slide_files ~/Dropbox/mattocci27.github.io/slide/TropE-rmd/rmd-slide_files
ln -snf ~/Dropbox/seminar/20190809TropE/rmd-slide.html ~/Dropbox/mattocci27.github.io/slide/TropE-rmd/rmd-slide.html
ln -snf ~/Dropbox/seminar/20190809TropE/rmd-slide.rmd ~/Dropbox/mattocci27.github.io/slide/TropE-rmd/rmd-slide.rmd

ln -snf ~/Dropbox/seminar/20190809TropE/rmd-slide_files ~/Dropbox/mattocci27.github.io/slide/TropE-rmd/rmd-slide_files 

ln -s ${ORI}/fc2.css ${DES}/fc2.css
ln -snf ${DES}/fc2.css ${ORI}/fc2.css


mkdir ~/Desktop/test2
cd ~/Desktop/test2
touch moge.txt
mkdir moge_dir
cd moge_dir
touch moge2.txt

ORI="/home/mattocci/Desktop/test2"
DES="/home/mattocci/Desktop/test"
OVERWRITE=true


link_files() {
  while read FILE
  do
    echo ${FILE}
  done < temp
  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}


tree > temp.txt

ls -R > temp.txt

find test2 > temp

link_files() {
  while read FILE
  do
    echo ${FILiE}
    [ -n "${jvOVERWRITE}" -a ${DES}/${FILE} ] && rm -f ${DES}/${FILE}
      ln -snf ${ORI}/${FILE} ${DES}/${FILE}
  done < temp
  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

link_files

```
