
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
