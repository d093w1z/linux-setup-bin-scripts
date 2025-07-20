#!/usr/bin/env bash

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-1"
theme='style-1'


# Options
yes=' Yes'
no=' No'

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm)"
  echo $selected
	if [[ "$selected" == "$yes" ]]; then
		exit 0
	else
		exit -1
	fi
}

run_cmd
