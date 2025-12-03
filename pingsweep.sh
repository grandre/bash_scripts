#!/bin/bash

green="\e[92m"
endcolor="\e[0m"

echo "Ping Sweeper"
echo "------------------------------------"
if [[ -n "$1" ]]; then
	echo "Scanning network $10/24 for live hosts..."
	for i in {1..254}; do

		ip="$1$i"

		ping -c 1 -W 1 "$ip" &> /dev/null &

		pid=$!

		wait $pid

		if [ "$?" -eq 0 ]; then
			echo -e "${green}$ip${endcolor}"
		fi
	done
else
	echo "How to use:"
	echo "./pingsweep.sh xxx.xxx.xxx."
	exit 1
fi
