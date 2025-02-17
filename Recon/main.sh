#!/bin/bash

IP_RANGES="ipRanges.txt"
cat "$IP_RANGES" | dnsx -ptr -resp-only -o reverse_dns_results.txt

awk '{print $NF}' reverse_dns_results.txt | anew domains.txt

for domain in $(cat domains.txt); do
    echo "--------------------------------------------------"
    echo "Starting reconnaissance for: $domain"
    echo "--------------------------------------------------"

   
    bash recon_script.sh "$domain"  

    echo "--------------------------------------------------"
    echo "Finished reconnaissance for: $domain"
    echo "--------------------------------------------------"
done

echo "All reconnaissance tasks completed!"
