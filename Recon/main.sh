#!/bin/bash

IP_RANGES="ipRanges.txt"
cat ipRanges.txt | dnsx -ptr -resp-only -o reverse_dns_results.txt

awk '{print $NF}' reverse_dns_results.txt | anew domains.txt


# Loop through the domains
for domain in $(cat domains.txt ); do
    echo "--------------------------------------------------"
    echo "Starting reconnaissance for: $domain"
    echo "--------------------------------------------------"

    # Execute your subdomain reconnaissance script
    bash recon_script.sh "$domain"  # Replace your_recon_script.sh with the actual name of your script

    echo "--------------------------------------------------"
    echo "Finished reconnaissance for: $domain"
    echo "--------------------------------------------------"
done

echo "All reconnaissance tasks completed!"
