#!/bin/bash

# Validate input
if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Usage: $0 <file_with_urls>"
    exit 1
fi

while IFS= read -r line; do
    if [ -n "$line" ]; then
        curl  "$line" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "\033[32m[+] $line is live\033[0m"   >> live_subDomain.txt # Green text for live
        else
            echo -e "\033[31m[-] $line is not reachable\033[0m"  # Red text for not reachable
        fi
    fi
done < "$1"