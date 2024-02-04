#!/usr/bin/env bash

if pgrep -x swaylock; then
	exit 0
else
	swaylock -f -e -K -i /home/ozoku/.local/wallpaper.png --indicator --clock \
		--indicator-x-position 100 --indicator-y-position 860 \
		--line-color 00000000 \
		--inside-color 11111133 \
		--ring-color 00000000 \
		--text-color ffffffff \
		--key-hl-color 00000044 \
		--separator-color 00000000 \
		--datestr "" "$@"
fi
