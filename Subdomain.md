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

```

## Subdomain enumeration tools
  ```
  	
• Subfinder     - https://github.com/projectdiscovery/subfinder
• Sublister     - https://github.com/aboul3la/Sublist3r
• Amass         - https://github.com/OWASP/Amass
• Assetfinder   - https://github.com/tomnomnom/assetfinder
• KnockPy       - https://github.com/guelfoweb/knock
• Anew          - https://github.com/tomnomnom/anew
• DNS gen       - https://github.com/ProjectAnte/dnsgen

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
5.GitHub recon 
  - Search repositories for API keys, configuration files,and credentials
  - Automated tools available
```