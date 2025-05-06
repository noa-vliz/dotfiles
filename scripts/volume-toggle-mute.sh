#!/bin/bash

amixer sset Master toggle > /dev/null
mute_status=$(amixer get Master | grep -o '\[on\]\|\[off\]' | head -1)
if [ "$mute_status" = "[off]" ]; then
    notify-send -t 500 "Muted"
else
    volume=$(amixer get Master | grep -o '[0-9]*%' | head -1)
    notify-send -t 500 "Unmuted" "$volume"
fi

