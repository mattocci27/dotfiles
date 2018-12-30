cd $HOME/Linux-Magic-Trackpad-2-Driver/linux/drivers/hid
make
sudo rmmod hid_magicmouse
sudo insmod ./hid-magicmouse.ko
cd
