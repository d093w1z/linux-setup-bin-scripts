#!/usr/bin/env bash

(
  flock 200

  killall -q polybar
  while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
  tray_output=eDP-1

  # Prefer HDMI-1 if present
  for m in $outputs; do
    if [[ $m == "HDMI-1" ]]; then
      tray_output=$m
    fi
  done

  for m in $outputs; do
    export MONITOR=$m

    if [[ $m == $tray_output ]]; then
      polybar --reload mybar_with_tray </dev/null >~/bin/logs/polybar-$m.log 2>&1 &
    else
      polybar --reload mybar_no_tray </dev/null >~/bin/logs/polybar-$m.log 2>&1 &
    fi
  done
) 200>/var/tmp/polybar-launch.lock

