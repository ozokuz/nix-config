#!/usr/bin/env bash

if pgrep -x ozokuidle; then
  killall ozokuidle
else
  # shellcheck disable=SC2016
  systemd-inhibit --who=ozokuidle --why="Prevent idling" --what=idle --mode=block perl -MPOSIX -e '$0="ozokuidle"; pause' &
fi

pkill -SIGRTMIN+8 waybar
