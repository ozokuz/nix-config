#!/usr/bin/env bash

running=$(systemctl --user show -p SubState --value hypridle)

if [ "$running" = "running" ]; then
	systemctl --user stop hypridle
else
	systemctl --user start hypridle
fi

pkill -SIGRTMIN+8 waybar
