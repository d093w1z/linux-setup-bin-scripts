#!/usr/bin/env sh

## https://github.com/polybar/polybar/issues/763#issuecomment-331604987
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload &
  done
else
  polybar --reload &
fi

## OLD CONFIG ##
# # Terminate already running bar instances
# killall -q polybar
# # Wait until the processes have been shut down
# while pgrep -x polybar >/dev/null; do
#   sleep 1
# done

# # Launch: 'top' is the name of my Polybar
# polybar &
