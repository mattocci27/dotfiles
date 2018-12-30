
# LG
xrandr --dpi 276 --fb 6400x2160 \
  --output eDP1 --mode 2560x1440 --panning 2560x1440+0+0 \
  --output DP2 --primary --mode 3840x2160 --panning 3840x2160+2560+0

xrandr --output DP2 --auto --left-of eDP1


# for full HD
xrandr --dpi 276 --fb 5440x3060 \
  --output HDMI1 --scale 1.5x1.5 \
  --output eDP1 --panning 2560x1440+0+1620
