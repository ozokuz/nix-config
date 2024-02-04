#!/usr/bin/env bash

location=$(cat /home/ozoku/.local/weather.txt)

for _ in {1..5}; do
	if text=$(curl -s "https://wttr.in/$location?format=1"); then
		text=$(echo "$text" | sed -E "s/\s+/ /g")
		if tooltip=$(curl -s "https://wttr.in/$location?format=4"); then
			tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
			echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
			exit
		fi
	fi
	sleep 2
done
echo "{\"text\":\"error\", \"tooltip\":\"error\"}"
