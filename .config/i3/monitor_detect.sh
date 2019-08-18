#!/bin/bash

#st_prev=$(cat /sys/class/drm/card0-HDMI-A-1/status)


st_prev="disconnected"

while :
do
    st_next=$(cat /sys/class/drm/card0-DP-1/status)
    if [ $st_prev != $st_next ]; then
        st_prev=$st_next
        if [ $st_next = "connected" ]; then
          xrandr --output DP1 --primary --scale 1x1 --mode 3440x1440 --right-of eDP1 --panning 3440x1440+2560+0 \
            --output eDP1 --scale 0.66x0.66 --panning 2560x1440+0+0
          xrandr --dpi 128
          xset r rate 300 50
        else
            xrandr --output eDP1 --mode 2560x1440 --output HDMI1 --off
        fi
        ~/.fehbg
    fi
    sleep 1
done
