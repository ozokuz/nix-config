#!/usr/bin/env bash

running=$(systemctl --user show -p SubState --value swayidle)

if [ "$running" = "running" ]; then
	echo ""
else
	echo ""
fi
