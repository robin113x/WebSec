```
Subfinder     : subfinder -d target.com -o subfinder.txt

sublist3r     : sublist3r -d target.com -o sublist3r.txt

amass enum -active -norecursive -noalts -d target.com -o amass.txt  &&  cat amass.txt|  grep -E '^[a-zA-Z][a-zA-Z0-9.-]*\.target\.com$'



shosubgo      - shosubgo -d target.com -s YourAPIKEY

dnscan         : ./dnscan -w n0kovo_subdomains_huge.txt -d robin.com

bbot           : bbot -t gokwik.co -p subdomain-enum -o bbot.txt
               : bbot -c modules.shodan_dns.api_key=ABCDEFGHIXXXXX


gobuster       : gobuster dns -d target.com -w /usr/share/wordlists/subdomain_megalist.txt -o gobuster.txt

crt.sh          : curl -s https://crt.sh/\?q\=\%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a subs_domain.txt

curl -s "https://otx.alienvault.com/api/v1/indicators/hostname/domain.com/passive_dns" | jq -r '.passive_dns[]?.hostname' | grep -E "^[a-zA-Z0-9.-]+\.domain\.com$" | sort -u | tee alienvault_subs.txt

curl -s "https://urlscan.io/api/v1/search/?q=domain:domain.com&size=10000" | jq -r '.results[]?.page?.domain' | grep -E "^[a-zA-Z0-9.-]+\.domain\.com$" | sort -u | tee urlscan_subs.txt

curl -s "http://web.archive.org/cdx/search/cdx?url=*.domain.com/*&output=json&collapse=urlkey" | jq -r '.[1:][] | .[2]' | grep -Eo '([a-zA-Z0-9._-]+\.)?domain\.com' | sort -u | tee webarcive_subs.txt

```
