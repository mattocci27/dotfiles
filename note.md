
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

ln -snf ${DOT_DIRECTORY}/${FILE} ${HOME}/${FILE}
ln -snf ~/dotfiles/.config/i3/config ~/.config/i3/config
ln -snf ~/dotfiles/.config/i3/monitor_detect.sh ~/.config/i3/monitor_detect.sh

ln -snf ~/dotfiles/.config/i3blocks/config ~/.config/i3blocks/config
ln -snf ~/dotfiles/.config/i3blocks/battery.sh ~/.config/i3blocks/battery.sh
ln -snf ~/dotfiles/.config/i3blocks/memory.py ~/.config/i3blocks/memory.py
ln -snf ~/dotfiles/.config/i3blocks/volume.sh ~/.config/i3blocks/volume.sh
```
