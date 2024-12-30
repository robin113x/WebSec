#!/bin/bash

# Validate input
if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Usage: $0 <file_with_urls>"
    exit 1
fi

# Read file line by line
while IFS= read -r line; do
    # Check if line is not empty
    if [ -n "$line" ]; then
        # Send request with a timeout of 5 seconds
        curl -s --max-time 5 --head "$line" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "\033[32m[+] $line is live\033[0m"   >> live_subDomain.# Green text for live
        else
            echo -e "\033[31m[-] $line is not reachable\033[0m"  # Red text for not reachable
        fi
    fi
done < "$1"