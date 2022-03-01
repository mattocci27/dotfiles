#!/bin/sh
set -e

usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  HDMI
  USB-C
Arguments:
  -h Print help
EOF
  exit 1
}

while getopts :fh opt; do
  case ${opt} in
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

HDMI_3440() {
  xrandr --output HDMI1 --primary --scale 1x1 --mode 3440x1440 --right-of eDP1 --panning 3440x1440+2560+0  --output eDP1 --scale 0.66x0.65 --panning 2560x1440+0+1
}

USB_C_3440() {
  xrandr --output DP1 --primary --scale 1x1 --mode 3440x1440 --right-of eDP1 --panning 3440x1440+2560+0  --output eDP1 --scale 0.66x0.65 --panning 2560x1440+0+1
}

command=$1
[ $# -gt 0 ] && shift

case $command in
  HDMI)
    HDMI_3440
    ;;
  USB-C*)
    USB_C_3440
    ;;
  *)
    usage
    ;;
esac
