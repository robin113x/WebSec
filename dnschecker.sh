#!/bin/bash

# Validate input
if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Usage: $0 <file_with_urls>"
    exit 1
fi

# Create or clear the output file
> live_subDomain.txt

# Set the maximum number of parallel jobs
MAX_PARALLEL=10
SEMAPHORE="/tmp/parallel_$$.lock"

# Function to manage parallel execution
limit_parallel() {
    while [ "$(jobs -rp | wc -l)" -ge "$MAX_PARALLEL" ]; do
        sleep 0.1
    done
}

# Read file line by line
while IFS= read -r line; do
    if [ -n "$line" ]; then
        # Limit the number of parallel jobs
        limit_parallel
        
        # Run curl in the background
        {
            curl "$line" &>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "[+] $line is live" | tee -a live_subDomain.txt
            else
                echo -e "[-] $line is not reachable"
            fi
        } &
    fi
done < "$1"

# Wait for all background jobs to finish
wait

echo "Scan complete. Live subdomains saved to live_subDomain.txt."
