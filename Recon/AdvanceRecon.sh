#!/bin/bash

# Usage Check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1
output="$HOME/Documents/$domain"
mkdir -p "$output"
cd "$output" || { echo "Failed to create/cd to directory"; exit 1; }

# API & Wordlists
APIKEY="$SHODAN_API_KEY"
WORDLISTS="/usr/share/wordlists/subdomain/sub.txt"
FUZZ_WORDLIST="/usr/share/wordlists/dirb/common.txt"
EXTENSIONS="xml,json,sql,db,log,yml,yaml,bak,txt,tar.gz,zip,php,aspx,jsp,html"
DNSCAN_WORDLIST="/usr/share/wordlists/subdomain/sub.txt"
RESOLVER="/usr/share/wordlists/subdomain/resolvers.txt"


log_message() {
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $1" | tee -a "$output/scan.log"
}



log_message "[+] Subdomain Enumeration 🌐️"

# Passive Sources
curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee "$output/crtsh.txt"
curl -s "https://otx.alienvault.com/api/v1/indicators/hostname/$domain/passive_dns" | jq -r '.passive_dns[]?.hostname' | sort -u | tee "$output/alienvault.txt"
curl -s "https://urlscan.io/api/v1/search/?q=domain:$domain&size=10000" | jq -r '.results[]?.page?.domain' | sort -u | tee "$output/urlscan.txt"
curl -s "http://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=json&collapse=urlkey" | jq -r '.[1:][] | .[2]' | sort -u | tee "$output/wayback.txt"
curl -s "https://certspotter.com/api/v1/issuances?domain=$domain&include_subdomains=true&expand=dns_names" | jq -r '.[].dns_names[]' | sort -u | tee "$output/certspotter.txt"

# Active Enumeration
echo "[+] Subdomain Enumeration by subfinder 🌐️"
subfinder -d "$domain" -all -recursive -o "$output/subfinder.txt"
echo "[+] Subdomain Enumeration by assetfinder 🌐️"
assetfinder -subs-only "$domain" | tee "$output/assetfinder.txt"
echo "[+] Subdomain Enumeration by amass 🌐️"
amass enum -norecursive -d "$domain" -o "$output/amass.txt" 
echo "[+] Subdomain Enumeration by SHODANx 🌐️"
shodanx subdomain -d "$domain" -ra -o "$output/shodanx.txt"
echo "[+] Subdomain Enumeration by DNSCAN 🌐️"
python3 /home/kali/Tools/subdomain/dnscan/dnscan.py -w "$DNSCAN_WORDLIST" -d "$domain" -o "$output/dnscan.txt"

wait


cat "$output"/*.txt | anew "$output/all_subdomains.txt"
massdns -r "$RESOLVER" -t A -o S "$output/all_subdomains.txt" > "$output/massdns_resolved.txt"

# --- Live Host Discovery ---
log_message "[+] Live Host Discovery 🚀"
awk '{print $1}' "$output/massdns_resolved.txt" | httpx -td -title -sc -ip -follow-redirects -status-code -probe -retries 2 -threads 100 -o "$output/httpx_results.txt"
awk '{print $1}' "$output/httpx_results.txt" | grep -E 'https?://' > "$output/live_hosts.txt"

# --- Port Scanning ---
log_message "[+] Port Scanning 📡"
sudo naabu -l "$output/live_hosts.txt" -c 200 -top-ports 1000 -o "$output/naabu_ports.txt"
awk '{print $1}' "$output/naabu_ports.txt" | sort -u > "$output/live_ips.txt"
sudo nmap -sV -iL "$output/live_ips.txt" -oN "$output/nmap_results.txt" --script=vuln

# --- Directory Brute-Forcing ---
log_message "[+] Content Discovery 🔎"
cat "$output/live_hosts.txt" | parallel -j 5 "dirsearch -u {} -w '$FUZZ_WORDLIST' -e '$EXTENSIONS' -x 403,404,500,400,502,503,429 --random-agent -t 50 -o '$output/dirsearch_{}.txt'"

# --- Vulnerability Scanning ---
log_message "[+] Vulnerability Scanning 💥"
nuclei -l "$output/live_hosts.txt" -t ~/nuclei-templates/cves/ -rl 10 -bs 2 -c 50 -o "$output/nuclei_results.txt"

# --- Subdomain Takeover ---
log_message "[+] Subdomain Takeover Detection 📦️"
subjack -w "$output/all_subdomains.txt" -t 50 -timeout 30 -ssl -o "$output/subjack_results.txt" -v

# --- Screenshotting ---
log_message "[+] Screenshotting 📸"
cat "$output/live_hosts.txt" | aquatone -out "$output/screenshots"

log_message "[+] Scan Completed! Results saved in $output/"
 