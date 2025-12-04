#!/usr/bin/env bash

player=$(playerctl --list-all | head -n 1)
class=$(playerctl -p "$player" metadata --format '{{playerName}}')

node=$(bspc query -N -n .window | while read n; do
    c=$(xprop -id "$n" WM_CLASS | awk -F\" '{print $4}')
    if [[ "${c,,}" == "${class,,}" ]]; then
        echo "$n"
        break
    fi
done)

[ -n "$node" ] && bspc node "$node" -f

