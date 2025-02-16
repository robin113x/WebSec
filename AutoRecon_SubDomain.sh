#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1

# Secure API Key Handling (Environment Variable)
APIKEY="$SHODAN_API_KEY"  # Set this in your .bashrc or .zshrc

output="$HOME/Documents/$domain"
mkdir -p "$output"
cd "$output" || { echo "Failed to create/cd to directory" ; exit 1; }

wordlists="/usr/share/wordlists/subdomain/sub.txt"

echo "[+] Running Subfinder, ShodanX, Sublist3r, and Shosubgo in parallel..."
subfinder -d "$domain" -o "$output/subfinder.txt" &
if [ $? -ne 0 ]; then echo "Error running subfinder"; fi
shodanx subdomain -d "$domain" -ra -o "$output/shodanx.txt" &
if [ $? -ne 0 ]; then echo "Error running shodanx"; fi
sublist3r -d "$domain" -o "$output/sublist3r.txt" &
if [ $? -ne 0 ]; then echo "Error running sublist3r"; fi
shosubgo -d "$domain" -s "$APIKEY" -o "$output/shosubgo.txt" &
if [ $? -ne 0 ]; then echo "Error running shosubgo"; fi
assetfinder -subs-only -domains "$domain"  | tee "$output/AssestFinder.txt" &
if [ $? -ne 0 ]; then echo "Error running assetfinder"; fi
wait
echo "[+] First batch completed."


echo "[+] Running Gobuster and Dnscan in parallel..."
gobuster dns -d "$domain" -w "$wordlists" -o "$output/gobuster.txt" &
if [ $? -ne 0 ]; then echo "Error running gobuster"; fi
python3 /home/kali/Tools/subdomain/dnscan/dnscan.py -w "$wordlists" -d "$domain" -o "$output/dnscan.txt" &
if [ $? -ne 0 ]; then echo "Error running dnscan"; fi
wait
echo "[+] Second batch completed."


echo "[+] Running Amass and Bbot in parallel..."
amass enum -active -norecursive -noalts -d "$domain" -o "$output/amass.txt" &
if [ $? -ne 0 ]; then echo "Error running amass"; fi
bbot -t "$domain" -p subdomain-enum -o "$output/bbot.txt" & # Consider exploring bbot's full potential
if [ $? -ne 0 ]; then echo "Error running bbot"; fi
wait
echo "[+] Third batch completed."


echo "[+] Fetching subdomains from crt.sh..."
curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee "$output/crtsh_subs.txt"
if [ $? -ne 0 ]; then echo "Error fetching crt.sh data"; fi

echo "[+] Fetching subdomains from AlienVault OTX..."
curl -s "https://otx.alienvault.com/api/v1/indicators/hostname/$domain/passive_dns" | jq -r '.passive_dns[]?.hostname' | grep -E "^[a-zA-Z0-9.-]+\.$domain$" | sort -u | tee "$output/alienvault_subs.txt"
if [ $? -ne 0 ]; then echo "Error fetching AlienVault OTX data"; fi

echo "[+] Fetching subdomains from URLScan..."
curl -s "https://urlscan.io/api/v1/search/?q=domain:$domain&size=10000" | jq -r '.results[]?.page?.domain' | grep -E "^[a-zA-Z0-9.-]+\.$domain$" | sort -u | tee "$output/urlscan_subs.txt"
if [ $? -ne 0 ]; then echo "Error fetching URLScan data"; fi

echo "[+] Fetching subdomains from Wayback Machine..."
curl -s "http://web.archive.org/cdx/search/cdx?url=*.$domain/*&output=json&collapse=urlkey" | jq -r '.[1:][] | .[2]' | grep -Eo "([a-zA-Z0-9._-]+\.)?$domain" | sort -u | tee "$output/wayback_subs.txt"
if [ $? -ne 0 ]; then echo "Error fetching Wayback Machine data"; fi


# Append domain to shosubgo output
awk '{print $1 ".$domain"}' "$output/shosubgo.txt" > "$output/shosubgo_full.txt" # No need for tee and mv
mv "$output/shosubgo_full.txt" "$output/shosubgo.txt"

# Consolidate all subdomain lists using anew (much more efficient)
cat "$output"/*.txt | anew "$output/all_subs.txt"  # all_subs.txt is created if it doesnt exist
if [ $? -ne 0 ]; then echo "Error consolidating subdomain lists"; fi


# httpx for live subdomains
cat "$output/all_subs.txt" | httpx -silent -status-code -follow-redirects -o "$output/live_subs.txt"
if [ $? -ne 0 ]; then echo "Error running httpx"; fi


echo "[+] Subdomain enumeration completed. Results saved in $output/"
