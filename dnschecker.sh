#!/bin/bash

# Validate input
if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Usage: $0 <file_with_urls>"
    exit 1
fi

# Create or clear the output file
> live_subDomain.txt


MAX_PARALLEL=50
SEMAPHORE="/tmp/parallel_$$.lock"

limit_parallel() {
    while [ "$(jobs -rp | wc -l)" -ge "$MAX_PARALLEL" ]; do
        sleep 0.1
    done
}


while IFS= read -r line; do
    if [ -n "$line" ]; then
        limit_parallel
        {
            curl "$line" &>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "[+] $line is live" | tee -a live_subDomain.txt
            else
                echo -e "\033[31m[-] $line is not reachable"
            fi
        } &
    fi
done < "$1"

wait

echo "Scan complete. Live subdomains saved to live_subDomain.txt."
