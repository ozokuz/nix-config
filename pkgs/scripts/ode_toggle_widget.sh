#!/usr/bin/env bash

state=$(eww get "${1}_state")
monitor=$(eww get "${1}_monitor")
active_monitor="$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .id')"

if [ "$state" == "closed" ]; then
	eww update "${1}_state=open"
	eww update "${1}_monitor=${active_monitor}"
	eww open "${1}${active_monitor}"
	exit 0
fi

if [ "$monitor" != "$active_monitor" ]; then
	eww update "${1}_monitor=${active_monitor}"
	eww close "${1}${monitor}"
	eww open "${1}${active_monitor}"
else
	eww update "${1}_state=closed"
	eww close "${1}${active_monitor}"
fi
