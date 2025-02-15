# ASN : ASNs will give us IP Addresses of owned servers ,These IPs will lead to more apex domains, websites, & services.
```
0.HURRICAN       : https://bgp.he.net/
1.ASNLookup      : https://github.com/yassineaboukir/Asnlookup
2.Metabigor      : https://github.com/j3ssie/metabigor?tab=readme-ov-file
3.Karma_v2       : https://github.com/Dheerajmadhukar/karma_v2
4.Shasubgo       : shosubgo  -d hcltecho.com -s shodan_api -o hctltecho.txt
5.ARIN           : https://search.arin.net/rdap/
6.Wtfis          : https://github.com/pirxthepilot/wtfis

```


# Subdomain ENUM : 
https://inteltechniques.com/tools/Domain.html
```


1.subfinder      : ./subfinder -d robin.com -active 
                     -binaryedge.io
2.amass          : amass enum -d robin.com
3.assestfinder   : ./assesfinder -subs-only robin.com
4.dnscan         : ./dnscan -w n0kovo_subdomains_huge.txt -d robin.com
5.sublist3r      : python sublist3r.py -d example.com
6.knockpy        : git clone https://github.com/guelfoweb/knock.git
7.dnsgen         : echo "robin.com" | dnsgen - | tee -a sub.txt
8.censys         : https://github.com/christophetd/censys-subdomain-finder
9.FFUF           : 
10.PureDNS       :
11.bbot          :https://github.com/blacklanternsecurity/bbot

```

## Subdomain enumeration tools
  ```
  	
• Subfinder     - https://github.com/projectdiscovery/subfinder

• Sublister     - https://github.com/aboul3la/Sublist3r

• Amass         - https://github.com/OWASP/Amass
                  amass enum -d robin.com | tee amass_subdomain.txt
                  grep -E '^[a-zA-Z][a-zA-Z0-9.-]*\.gokwik\.co$' all_subdomain_gokwik.txt

• Assetfinder   - https://github.com/tomnomnom/assetfinder
              


• shosubgo      - shosubgo -d target.com -s YourAPIKEY

• dnscan         : ./dnscan -w n0kovo_subdomains_huge.txt -d robin.com

• bbot           : bbot -t gokwik.co -p subdomain-enum -o bbot.txt
                 : bbot -c modules.shodan_dns.api_key=ABCDEFGHIXXXXX

  ```

## File Mangement
```
• Anew          - https://github.com/tomnomnom/anew
                  cat sublist3r_gokwik.txt | anew all_subdomain_gokwik.txt
                  cat assestfinder_gokwik.txt | anew all_subdomain_gokwik.txt
                  cat subfinder_gokwik.txt | anew all_subdomain_gokwik.txt
                  cat sublist3r_gokwik.txt | anew all_subdomain_gokwik.txt

```

## Subdomain enumeration from webites

 ```

1. Virustotal website   - https://www.virustotal.com/
2. Censys Website       - https://censys.io/
3. Projectdiscovery     - https://chaos.projectdiscovery.io/#/
4. Crt.sh               - https://crt.sh

  ```

## Filterning Live Domain

```
1.httpx : cat subdomain.txt | httpx  (-favico)
2.httpprobe


```

## Service ENUM / Port Scanning 

```
1.NMap:
2.GoBuster
3.NetCat


```
## Version & OS Assessment 

```

```


# Manul Recon
```
1.Browser Devloper Tools : Inspecting HTTP responses, headers, and scripts.
2.Browser Extension      : Wappalyzer , BuildWith
3.CLI                    : wget ,cURl
4.Editor                 : Sublime/VsCode

```

# Spidering (ZAP)
```
1.Google Dorking        : https://nitinyadav00.github.io/Bug-Bounty-Search-Engine/ 
2.WHOIS & Reverse WHOIS
3.IP Address LOOKUPS    : nslookup
4.Certificate parsing   : openssl
  - Certificates may contain valuable information
  - Uncover hidden subdomains
5.GitHub recon : GithubGest
  - Search repositories for API keys, configuration files,and credentials
  - Automated tools available
6.Pastebin
```
 # URL 
 ```
 1.gau : https://github.com/lc/gau 
 2.goSpider : 

 ```
