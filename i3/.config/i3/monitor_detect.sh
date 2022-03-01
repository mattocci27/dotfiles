#!/bin/sh

# Get out of town if something errors
# set -e

# Get info on the monitors
eDP_1_STATUS=$(cat /sys/class/drm/card0/card0-eDP-1/status)
DP_1_STATUS=$(cat /sys/class/drm/card0/card0-DP-1/status)
DP_2_STATUS=$(cat /sys/class/drm/card0/card0-DP-2/status)
HDMI_1_STATUS=$(cat /sys/class/drm/card0/card0-HDMI-A-1/status)

eDP_1_ENABLED=$(cat /sys/class/drm/card0/card0-eDP-1/enabled)
DP_1_ENABLED=$(cat /sys/class/drm/card0/card0-DP-1/enabled)
DP_2_ENABLED=$(cat /sys/class/drm/card0/card0-DP-2/enabled)
HDMI_1_STATUS=$(cat /sys/class/drm/card0/card0-HDMI-A-1/enabled)

# Check to see if our state log exists
if [ ! -f /tmp/monitor ]; then
    touch /tmp/monitor
    STATE=5
else
    STATE=$(cat /tmp/monitor)
fi

# The state log has the NEXT state to go to in it

# If monitors are disconnected, stay in state 1
if [ "disconnected" = "$DP_1_STATUS" -a "disconnected" = "$DP_2_STATUS" -a "disconnected" = "$HDMI_1_STATUS" ]; then
    STATE=1
fi

echo "${STATE}"

case $STATE in
    1)
    # laptop monitor (eDP-1) is on, projectors not connected
    /usr/bin/xrandr --output eDP1 --auto
    state=2
    ;;
    2)
    # laptop monitor (eDP1) is on, projectors are connected but inactive
    /usr/bin/xrandr --output eDP1 --auto --output DP1 --off --output DP2 --off
    STATE=3 
    ;;
    3)
    # laptop monitor (eDP1) is off, projectors are on
    if [ "connected" = "$DP_1_STATUS" ]; then
        /usr/bin/xrandr --output eDP1 --off --output DP1 --auto
        TYPE="DP1"
    elif [ "connected" = "$DP_2_STATUS" ]; then
        /usr/bin/xrandr --output DP2 --off --output DP2 --auto
        TYPE="DP2"
    fi
    /usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE"
    STATE=4
    ;;
    4)
    # laptop monitor (eDP1) is on, projectors are mirroring
    if [ "connected" = "$DP_1_STATUS" ]; then
        /usr/bin/xrandr --output eDP1 --auto --output DP1 --auto
        TYPE="DP1"
    elif [ "connected" = "$DP_2_STATUS" ]; then
        /usr/bin/xrandr --output DP2 --auto --output DP2 --auto
        TYPE="DP2"
    fi
    /usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE mirroring"
    STATE=5
    ;;
    5) 
      # laptop monitor is on, projectors are extending (USB-C)
    if [ "connected" = "$DP_1_STATUS" ]; then
      xrandr --output DP1 --primary --scale 1x1 --mode 3440x1440 --right-of eDP1 --panning 3440x1440+2560+0  --output eDP1 --scale 0.65x0.65 --panning 2560x1440+0+0
      xset r rate 300 50
      TYPE="DP1"
    elif [ "connected" = "$DP_2_STATUS" ]; then
      /usr/bin/xrandr --output DP2 --auto --output DP2 --auto --above eDP1
      TYPE="DP2"
    fi
    /usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE mirroring"
    STATE=6
    ;;
    6)
      # laptop monitor is on, projectors are extending (HDMI)
    if [ "connected" = "$HDMI_1_STATUS" ]; then
      xrandr --output HDMI1 --primary --scale 1x1 --mode 3440x1440 --right-of eDP1 --panning 3440x1440+2560+0  --output eDP1 --scale 0.66x0.65 --panning 2560x1440+0+1
      xset r rate 300 50
      TYPE="DP1"
    elif [ "connected" = "$DP_2_STATUS" ]; then
      /usr/bin/xrandr --output DP2 --auto --output DP2 --auto --above eDP1
      TYPE="DP2"
    fi
    /usr/bin/notify-send -t 5000 --urgency=low "Graphics Update" "Switched to $TYPE extending"
    STATE=2
    ;;
    *)
    # Unknown state, assume we're in 1
    STATE=1 
esac

echo $STATE > /tmp/monitor
