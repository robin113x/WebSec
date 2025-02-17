#!/bin/bash

# Array of in-scope domains (replace with the full list from the previous response)
domains=(
    "playtika.com"
    "slotomania.com"
    "bingoblitz.com"
    "playticorp.com"
    "playwsop.com"
    "serious.li"
    "seriously.com"
    "wooga.com"
    "houseoffun.com"
    "caesarsgames.com"
    "junesjourney.com"
    "solitairegrandharvest.com"
    "bestfiends.com"
    "buffalo-ggn.net" # Example for a non-wildcard domain
    "boardkingsgame.com"
    "redecor.com"
    "justfall.lol"
    "justplay.lol"
    "1v1.lol"
    "governorofpoker.com"
    "gop3.nl"
    "monopoly-poker.com"
    "vegasdowntownslots.com"
    "pokerheat.com"
    "redocor.com"
    "bestfiendsstars.com"
    "jellysplash.com"
    "switchcraft.com"
    "tropicats.com"
    "pearlsperil.com"
    # ... Add all other domains
)

# Loop through the domains
for domain in "${domains[@]}"; do
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
