#!/bin/bash

#!/usr/bin/env sh
## https://github.com/polybar/polybar/issues/763#issuecomment-450940924
#!/bin/bash
(
  flock 200

  killall -q polybar

  while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
  tray_output=eDP-1

  for m in $outputs; do
    if [[ $m == "HDMI-1" ]]; then
        tray_output=$m
        echo $tray_output $m
    fi
  done

  for m in $outputs; do
    export MONITOR=$m
    export TRAY_POSITION=none
    if [[ $m == $tray_output ]]; then
      TRAY_POSITION=right
    fi

    polybar --reload mybar </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
    disown
  done
) 200>/var/tmp/polybar-launch.lock




## OLD CONFIG ##
## https://github.com/polybar/polybar/issues/763#issuecomment-331604987
# if type "xrandr"; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m polybar --reload &
#   done
# else
#   polybar --reload &
# fi

# # Terminate already running bar instances
# killall -q polybar
# # Wait until the processes have been shut down
# while pgrep -x polybar >/dev/null; do
#   sleep 1
# done

# # Launch: 'top' is the name of my Polybar
# polybar &
