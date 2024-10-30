#!/usr/bin/env bash

if pgrep -x ozokuidle; then
	killall ozokuidle
else
	systemd-inhibit --who=ozokuidle --why="Prevent idling" --mode=block perl -MPOSIX -e '$0="ozokuidle"; pause' &
fi

pkill -SIGRTMIN+8 waybar
