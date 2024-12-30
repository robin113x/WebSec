#!/bin/bash

# Validate input
if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Usage: $0 <file_with_urls>"
    exit 1
fi

while IFS= read -r line; do
    # Check if line is not empty
    if [ -n "$line" ]; then
        curl -s --max-time 5 --head "$line" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "\033[32m[+] $line is live\033[0m"  
        fi
    fi
done < "$1"