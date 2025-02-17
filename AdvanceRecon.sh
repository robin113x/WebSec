#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1
output="$HOME/Documents/$domain"
mkdir -p "$output"
cd "$output" || { echo "Failed to create/cd to directory" ; exit 1; }

APIKEY="$SHODAN_API_KEY" 
WORDLISTS="/usr/share/wordlists/subdomain/sub.txt" 
FUZZ_WORDLIST="/usr/share/wordlists/dirb/common.txt" 
EXTENSIONS="xml,json,sql,db,log,yml,yaml,bak,txt,tar.gz,zip,php,aspx,jsp,html" 
DNSCAN_WORDLIST="/usr/share/wordlists/subdomain/sub.txt"


log_message() {
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $1" >> "$output/scan.log"
    echo "[$timestamp] $1"
}

# --- Subdomain Enumeration ---
log_message "[+] Subdomain Enumeration 🌐️"
log_message "--------------------------"

# Passive Sources
curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee "$output/crtsh.txt" &
if [ $? -ne 0 ]; then log_message "Error fetching crt.sh data"; fi
curl -s "https://otx.alienvault.com/api/v1/indicators/hostname/$domain/passive_dns" | jq -r '.passive_dns[]?.hostname' | grep -E "^[a-zA-Z0-9.-]+\.$domain$" | sort -u | tee "$output/alienvault.txt" &
if [ $? -ne 0 ]; then log_message "Error fetching AlienVault OTX data"; fi
curl -s "https://urlscan.io/api/v1/search/?q=domain:$domain&size=10000" | jq -r '.results[]?.page?.domain' | grep -E "^[a-zA-Z0-9.-]+\.$domain$" | sort -u | tee "$output/urlscan.txt" &
if [ $? -ne 0 ]; then log_message "Error fetching URLScan data"; fi
curl -s "http://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=json&collapse=urlkey" | jq -r '.[1:][] | .[2]' | grep -Eo "([a-zA-Z0-9._-]+\.)?$domain" | sort -u | tee "$output/wayback.txt" &
if [ $? -ne 0 ]; then log_message "Error fetching Wayback Machine data"; fi

# Active Enumeration (Prioritized)
subfinder -d "$domain" -o "$output/subfinder.txt" &
if [ $? -ne 0 ]; then log_message "Error running subfinder"; fi
assetfinder -subs-only  "$domain"  | tee "$output/assetfinder.txt" &
if [ $? -ne 0 ]; then log_message "Error running assetfinder"; fi
amass enum -active -norecursive  -d "$domain" -o "$output/amass.txt" &
if [ $? -ne 0 ]; then log_message "Error running amass"; fi
shodanx subdomain -d "$domain" -ra -o "$output/shodanx.txt" &  # ShodanX
if [ $? -ne 0 ]; then log_message "Error running shodanx"; fi
python3 /home/kali/Tools/subdomain/dnscan/dnscan.py -w "$DNSCAN_WORDLIST" -d "$domain" -o "$output/dnscan.txt" & # dnscan
if [ $? -ne 0 ]; then log_message "Error running dnscan"; fi

wait

# Consolidate subdomains
cat "$output"/*.txt | anew "$output/all_subdomains.txt"
if [ $? -ne 0 ]; then log_message "Error consolidating subdomain lists"; fi

# --- Live Host Discovery (httpx) ---
log_message "\n[+] Live Host Discovery (httpx) 🚀"
log_message "-----------------------------------"

cat "$output/all_subdomains.txt" | httpx -td -title -sc -ip -follow-redirects -status-code -probe  -retries 2 -threads 100 -o "$output/httpx_results.txt"
if [ $? -ne 0 ]; then log_message "Error running httpx"; fi

cat "$output/httpx_results.txt" | awk '{print $1}' > "$output/live_subdomains.txt"
if [ $? -ne 0 ]; then log_message "Error extracting live subdomains"; fi

# --- Port Scanning (naabu) ---
log_message "\n[+] Port Scanning 📡"
log_message "--------------------"

naabu -l "$output/live_subdomains.txt" -c 200 -ports 80,443,8080,8443,8000,8888,8081,8181,3306,5432,6379,27017,15672,10000,9090,5900 -o "$output/naabu_ports.txt" &
if [ $? -ne 0 ]; then log_message "Error running naabu"; fi
sudo nmap -sV -iL "$output/live_subdomains.txt" -oN "$output/naabu_ports.txt" --script=vul

wait

# --- Content Discovery (dirsearch) ---
log_message "\n[+] Content Discovery (dirsearch) 🔎"
log_message "-------------------------------"

while IFS= read -r subdomain; do
    log_message "[+] Scanning: $subdomain"
    dirsearch -u "https://$subdomain" -w "$FUZZ_WORDLIST" -e "$EXTENSIONS" -x 403,404,500,400,502,503,429 --random-agent -t 50 -o "$output/dirsearch_$subdomain.txt" &
    if [ $? -ne 0 ]; then log_message "Error running dirsearch for $subdomain"; fi
done < "$output/live_subdomains.txt"
wait

# --- Vulnerability Scanning (nuclei) ---
log_message "\n[+] Vulnerability Scanning (nuclei) 💥"
log_message "-----------------------------------"

nuclei -l "$output/live_subdomains.txt" -t critical,high,medium -rl 10 -bs 2 -c 50 -o "$output/nuclei_results.txt" # Adjust rate limit as needed
if [ $? -ne 0 ]; then log_message "Error running nuclei"; fi

wait
# --- Screenshotting (eyewitness) ---
log_message "\n[+] Screenshotting 📸"
log_message "--------------------"

eyewitness --web -f "$output/live_subdomains.txt" --threads 10 -d "$output/screenshots"
if [ $? -ne 0 ]; then log_message "Error running eyewitness"; fi

# --- Subdomain Takeover Detection (subzy) ---
log_message "\n[+] Subdomain Takeover Detection 📦️"
log_message "------------------------------------"

subzy run --targets "$output/all_subdomains.txt" --concurrency 100 --hide-fails --verify-ssl -o "$output/subzy_results.txt"
if [ $? -ne 0 ]; then log_message "Error running subzy"; fi

log_message "\n[+] Scan Completed! Results saved in $output/"

