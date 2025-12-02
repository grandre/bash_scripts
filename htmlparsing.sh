#!/bin/bash

light_blue="\e[94m"
end_color="\e[0m"
echo "HTML Parsing for hosts"
echo "------------------------------------"

if [[ -n $1 ]]; then
	url=$1
	filtered_links=$(curl -s "$url" | grep -o -E 'href="[^"]*"' | cut -d'"' -f2 |  grep -E '^(http|https)://|^([0-9]{1,3}\.){3}[0-9]{1,3}')
	while IFS= read -r link; do
		hostname=$(echo "$link" | cut -d'/' -f3 | sed 's/\/.*//')
		if [[ -z "$hostname" ]]; then
			continue
		fi
		ip_address=$(host "$hostname" | awk '/has address/ {print $4}' | head -n 1)
		if [[ -n "ip_address" ]]; then
			echo -e "URL: $link ${light_blue}->${end_color} IP: $ip_address"
		else
			echo -e "URL: $link ${light_blue}->${end_color} IP: Could not resolve hostname ($hostname)"
		fi
	done <<< "$filtered_links"
else
	echo "how to use:"
	echo "./htmlparsing.sh www.target.com"
	exit 1
fi
