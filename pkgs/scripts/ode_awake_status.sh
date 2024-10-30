#!/usr/bin/env bash

running=$(systemctl --user show -p SubState --value hypridle)

if [ "$running" = "running" ]; then
	echo ""
else
	echo ""
fi
