#!/bin/bash

GREEN="\e[92m"
ENDCOLOR="\e[0m"

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Usage: $0 <target_ip> <start_port> <end_port>"
	exit 1
fi

TARGET_IP="$1"
START_PORT="$2"
END_PORT="$3"

echo "Scanning ports $START_PORT-$END_PORT on $TARGET_IP..."

for PORT in $(seq "$START_PORT" "$END_PORT"); do
	timeout 1 bash -c "echo > /dev/tcp/$TARGET_IP/$PORT" 2>/dev/null

	if [ $? -eq 0 ]; then
		echo -e "Port $PORT is ${GREEN}open${ENDCOLOR}"
	fi
done

echo "Scan complete."
