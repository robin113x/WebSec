
#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1
output="$HOME/Documents/$domain"
mkdir -p "$output"
cd "$output" || { echo "Failed to create/cd to directory" ; exit 1; }

APIKEY="$SHODAN_API_KEY"  # From environment variable (set in .bashrc or .zshrc)
WORDLISTS="/usr/share/wordlists/subdomain/sub.txt" # Or your preferred wordlist path
FUZZ_WORDLIST="/usr/share/wordlists/dirb/common.txt" # Wordlist for fuzzing (adjust as needed)
EXTENSIONS="xml,json,sql,db,log,yml,yaml,bak,txt,tar.gz,zip,php,aspx,jsp,html" # Extensions for dirsearch


echo "[+] Subdomain Enumeration 🌐️"
echo "--------------------------"


curl -s "https://crt.sh/?q=%.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee "$output/crtsh.txt" &
if [ $? -ne 0 ]; then echo "Error fetching crt.sh data"; fi
curl -s "https://otx.alienvault.com/api/v1/indicators/hostname/$domain/passive_dns" | jq -r '.passive_dns[]?.hostname' | grep -E "^[a-zA-Z0-9.-]+\.$domain$" | sort -u | tee "$output/alienvault.txt" &
if [ $? -ne 0 ]; then echo "Error fetching AlienVault OTX data"; fi
curl -s "https://urlscan.io/api/v1/search/?q=domain:$domain&size=10000" | jq -r '.results[]?.page?.domain' | grep -E "^[a-zA-Z0-9.-]+\.$domain$" | sort -u | tee "$output/urlscan.txt" &
if [ $? -ne 0 ]; then echo "Error fetching URLScan data"; fi
curl -s "http://web.archive.org/cdx/search/cdx?url=*.${domain}/*&output=json&collapse=urlkey" | jq -r '.[1:][] | .[2]' | grep -Eo "([a-zA-Z0-9._-]+\.)?$domain" | sort -u | tee "$output/wayback.txt" &
if [ $? -ne 0 ]; then echo "Error fetching Wayback Machine data"; fi

# Active Enumeration
subfinder -d "$domain" -o "$output/subfinder.txt" &
if [ $? -ne 0 ]; then echo "Error running subfinder"; fi
assetfinder -subs-only -domains "$domain" "$domain" | tee "$output/assetfinder.txt" &
if [ $? -ne 0 ]; then echo "Error running assetfinder"; fi
amass enum -active -norecursive -noalts -d "$domain" -o "$output/amass.txt" &
if [ $? -ne 0 ]; then echo "Error running amass"; fi
shodanx subdomain -d "$domain" -ra -o "$output/shodanx.txt" &  # ShodanX
if [ $? -ne 0 ]; then echo "Error running shodanx"; fi


python3 /home/kali/Tools/subdomain/dnscan/dnscan.py -w "$WORDLISTS" -d "$domain" -o "$output/dnscan.txt" &
if [ $? -ne 0 ]; then echo "Error running dnscan"; fi


wait


cat "$output"/*.txt | anew "$output/all_subdomains.txt"
if [ $? -ne 0 ]; then echo "Error consolidating subdomain lists"; fi

# --- Live Host Discovery (httpx) ---
echo "\n[+] Live Host Discovery (httpx) 🚀"
echo "-----------------------------------"

cat "$output/all_subdomains.txt" | httpx -td -title -sc -ip -follow-redirects -status-code -probe -timeout 5s -retries 2 -threads 100 -o "$output/httpx_results.txt"
if [ $? -ne 0 ]; then echo "Error running httpx"; fi

cat "$output/httpx_results.txt" | awk '{print $1}' > "$output/live_subdomains.txt"
if [ $? -ne 0 ]; then echo "Error extracting live subdomains"; fi

# --- Port Scanning  ---
echo "\n[+] Port Scanning 📡"
echo "--------------------"

naabu -l "$output/live_subdomains.txt" -c 200 -ports 80,443,8080,8443,8000,8888,8081,8181,3306,5432,6379,27017,15672,10000,9090,5900 -o "$output/naabu_ports.txt" &
if [ $? -ne 0 ]; then echo "Error running naabu"; fi

wait 


echo "\n[+] Content Discovery (dirsearch) 🔎"
echo "-------------------------------"

while IFS= read -r subdomain; do
    echo "[+] Scanning: $subdomain"
    dirsearch -u "https://$subdomain" -w "$FUZZ_WORDLIST" -e "$EXTENSIONS" -x 403,404,500,400,502,503,429 --random-agent -t 50 -o "$output/dirsearch_$subdomain.txt" &
    if [ $? -ne 0 ]; then echo "Error running dirsearch for $subdomain"; fi
done < "$output/live_subdomains.txt"
wait #Wait for content discovery to complete


echo "\n[+] Vulnerability Scanning (nuclei) 💥"
echo "-----------------------------------"

nuclei -l "$output/live_subdomains.txt" -t critical,high,medium -rl 10 -bs 2 -c 50 -o "$output/nuclei_results.txt"
if [ $? -ne 0 ]; then echo "Error running nuclei"; fi


echo "\n[+] Screenshotting 📸"
echo "--------------------"

eyewitness --web -f "$output/live_subdomains.txt" --threads 10 -d "$output/screenshots"
if [ $? -ne 0 ]; then echo "Error running eyewitness"; fi

# --- Subdomain Takeover Detection (subzy) ---
echo "\n[+] Subdomain Takeover Detection 📦️"
echo "------------------------------------"

subzy run --targets "$output/all_subdomains.txt" --concurrency 100 --hide-fails --verify-ssl -o "$output/subzy_results.txt"
if [ $? -ne 0 ]; then echo "Error running subzy"; fi

echo "\n[+] Scan Completed! Results saved in $output/"
