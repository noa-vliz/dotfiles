#!/bin/bash

amixer sset Master 1+ > /dev/null
volume=$(amixer get Master | grep -o '[0-9]*%' | head -1)
notify-send -t 500 "Volume Up" "$volume"
