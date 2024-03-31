#!/bin/bash
arg="${1:-}"
case "$arg" in
  --speakers)
    SINK="alsa_output.pci-0000_0a_00.3.analog-stereo"
    pacmd set-default-sink "$SINK"
    pacmd list-sink-inputs | grep index | while read line; do
      pacmd move-sink-input `echo $line | cut -f2 -d' '` "$SINK"
    done
    notify-send "Switched to speakers!"
    ;;
  --headphones)
    SINK="alsa_output.usb-Logitech_Logitech_G430_Gaming_Headset-00.analog-stereo"
    pacmd set-default-sink "$SINK"
    pacmd list-sink-inputs | grep index | while read line; do
      pacmd move-sink-input `echo $line | cut -f2 -d' '` "$SINK"
    done
    notify-send "Switched to headphones!"
    ;;
  *)
    # Setting this as the default lets polybar call the script and display
    # an icon of some sort on the icon bar. The character I used isn't
    # showing up right on this non-linux machine I'm using, so replace "X"
    # with whatever character or symbol you want on your polybar.
    echo "X"
    ;;
esac
