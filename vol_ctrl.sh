#!/bin/zsh
OPT=$1
if [[ $OPT == "mute" ]]
then
	for SINK in $(pactl list sinks | grep "Sink #"|cut -b7-)
	do
	  pactl set-sink-mute $SINK toggle
	done
else
	VOLUME=$OPT
	for SINK in $(pactl list sinks | grep "Sink #"|cut -b7-)
	do
	  pactl set-sink-volume $SINK $VOLUME
	done
fi
# pactl set-sink-mute alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo toggle



