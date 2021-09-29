# Thinkpad

## Trackpoint

```{shell}
# cat /etc/libinput/local-overrides.quirks
[Lenovo X1 Carbon 6th Trackpoint]
MatchUdevType=pointingstick
MatchName=*TPPS/2 Elan TrackPoint*
MatchDMIModalias=dmi:*svnLENOVO:*:pvrThinkPadX1Carbon6th*
AttrTrackpointMultiplier=0.8
```

## Trackpad

```{shell}
# cat /etc/X11/xorg.conf.d/70-synaptics.conf 
Section "InputClass"
        Identifier "touchpad catchall"
        Driver "libinput"
        MatchIsTouchpad "on"
        Option "VertEdgeScroll" "on"
        Option      "CircularScrolling"         "on"
        Option      "VertScrollDelta"          "-111"
        Option      "HorizScrollDelta"         "-111"
        Option      "TapButton1"                  "1"
        Option      "FingerLow" "20"
        Option      "FingerHigh" "50"
        Option      "HorizHysteresis" "40"
        Option      "VertHysteresis"  "40"
EndSection

```

## Keyboard

```{shell}
# cat /etc/X11/xorg.conf.d/00-keyboard.conf

# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
        Option "XkbModel" "pc105"
        Option "XkbOptions" "ctrl:swapcaps"
EndSection
```

