#!/usr/bin/env bash

running=$(systemctl --user show -p SubState --value swayidle)

if [ "$running" = "running" ]; then
	systemctl --user stop swayidle
else
	systemctl --user start swayidle
fi

pkill -SIGRTMIN+8 waybar
