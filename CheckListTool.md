# 🐞 Comprehensive Bug Bounty Checklist (Basic to Advanced)

## 1. Information Gathering

### Basic
- [ ] Subdomain enumeration: `assetfinder`, `amass`, `subfinder`, `crt.sh`
- [ ] DNS records analysis: `dnsenum`, `dig`, `dnsrecon`
- [ ] Technology stack identification: `Wappalyzer`, `WhatWeb`, `BuiltWith`
- [ ] WHOIS info and IP range mapping: `whois`, `ipinfo.io`, `bgp.he.net`
- [ ] Robots.txt / sitemap.xml analysis: `dirsearch`, `gobuster`

### Intermediate
- [ ] Cloud provider detection: `httprobe`, HTTP headers, favicon hashes
- [ ] Historical data: `waybackurls`, `gau`, `hakrawler`
- [ ] JavaScript file parsing: `LinkFinder`, `JSParser`, `SecretFinder`
- [ ] GitHub/GitLab repo analysis: `truffleHog`, `gitrob`, GitHub dorks

### Advanced
- [ ] Employee info for OSINT: `LinkedIn`, `hunter.io`, `theHarvester`
- [ ] ASN-based enumeration: `amass intel`, `bgp.he.net`, `censys.io`
- [ ] Certificate transparency logs: `crt.sh`, `Certspotter`, `Censys`
- [ ] CDN/WAF behavior: `WAFW00F`, header analysis

---

## 2. Authentication Testing

### Basic
- [ ] Rate limiting/brute force: `hydra`, `nmap`, `ffuf`, `wfuzz`
- [ ] Default credentials: Manual, default creds DBs
- [ ] Password policy assessment: Manual

### Intermediate
- [ ] MFA analysis: Manual, `evilginx`
- [ ] Session management flaws: `Burp Suite`, inspect tokens/cookies
- [ ] Account enumeration: Response diffing tools

### Advanced
- [ ] JWT vulnerabilities: `jwt_tool`, `HackBar`
- [ ] OAuth flaws: `Burp Suite`, `AAuthz`
- [ ] SSO testing: SAML toolkits, manual fuzzing
- [ ] Password reset flaws: Manual, proxy interception

---

## 3. Authorization Testing

### Basic
- [ ] IDOR: `Burp Repeater`, `Autorize`, `ffuf`
- [ ] Horizontal privilege escalation: Manual

### Intermediate
- [ ] Missing function-level access: `Autorize`, logic flow review
- [ ] Role-based API access: `Postman`, `Burp`
- [ ] Vertical privilege escalation: Manual

### Advanced
- [ ] JWT claims tampering: `jwt_tool`
- [ ] Business logic bypass: Manual
- [ ] OAuth scope manipulation: `AAuthz`

---

## 4. Input Validation Testing

### Basic
- [ ] Reflected XSS: `XSStrike`, `DalFox`, `Burp`
- [ ] SQL Injection: `sqlmap`, `sqliv`
- [ ] Open Redirects: Manual

### Intermediate
- [ ] Stored/DOM XSS: `DalFox`, browser console
- [ ] Command Injection: Manual, `Commix`
- [ ] SSRF: `Burp Collaborator`, `Interactsh`
- [ ] File upload bypass: `Burp`, `Explo Upload Scanner`

### Advanced
- [ ] XXE: `Burp`, DTD injection
- [ ] SSTI: `tplmap`, PayloadsAllTheThings
- [ ] HTTP header injection: `Burp`, `http-smuggler`
- [ ] HTTP parameter pollution: Manual, fuzzers
- [ ] WebSocket fuzzing: `Burp`, `WS King`

---

## 5. Configuration Testing

### Basic
- [ ] Directory listing: Browser, `dirsearch`, `gobuster`
- [ ] Default creds/setup pages: `nmap`, manual
- [ ] Missing headers: `SecurityHeaders.com`, `curl -I`

### Intermediate
- [ ] CORS misconfig: `corsy`, `CORS Misconfig Scanner`
- [ ] Verbose errors: Manual, Burp
- [ ] HTTP methods: `nmap`, `curl -X OPTIONS`

### Advanced
- [ ] Cookie attributes: `Burp`, DevTools
- [ ] Clickjacking: iframe test
- [ ] CSRF: `Burp`, `csrfpoccreator`

---

## 6. Business Logic Testing

### Basic
- [ ] Negative values: Manual tampering
- [ ] Client-side validation bypass: Modify JS, intercept

### Intermediate
- [ ] Price/quantity manipulation: `Burp`
- [ ] Workflow bypass: Macro replay

### Advanced
- [ ] Race conditions: `race-the-web`, `Turbo Intruder`
- [ ] Referral/trial abuse: Manual analysis
- [ ] Time-based access: Delayed logic testing

---

## 7. API Testing

### Basic
- [ ] Fuzz API inputs: `Postman`, `ffuf`, `Burp`
- [ ] Rate limiting: Manual, `Intruder`

### Intermediate
- [ ] BOLA: `Autorize`, `Burp`
- [ ] Excessive data exposure: Verbose errors
- [ ] Mass assignment: Hidden field injection

### Advanced
- [ ] GraphQL flaws: `GraphQLmap`, `InQL`, `Altair`
- [ ] Asset management: `amass`, `gau`, `assetnote`
- [ ] JWT in APIs: `jwt_tool`

---

## 8. Mobile-Specific Testing

### Basic
- [ ] Insecure storage: `MobSF`, manual file analysis
- [ ] Insecure communication: `Burp`, cert check

### Intermediate
- [ ] Reverse engineering: `apktool`, `jadx`, `class-dump`
- [ ] Debug info/logs: APK analysis

### Advanced
- [ ] Code tampering: `Frida`, `objection`
- [ ] Dynamic analysis: `MobSF`, Frida scripts
- [ ] Intent abuse: `adb`, `drozer`

---

## 9. Post-Exploitation

### Basic
- [ ] Sensitive data discovery: `Burp`, browser
- [ ] Impact validation: Confirm access levels

### Intermediate
- [ ] Privilege escalation: Enumeration, shell exploits
- [ ] Internal pivoting: SSRF, VPN access

### Advanced
- [ ] Persistence: Reverse shells, cron jobs
- [ ] Chain exploits: XSS → CSRF, SSRF → RCE
- [ ] Internal lateral movement: Enum + SSRF

---

## Advanced Techniques & Tools

| Technique                | Tools / Notes                                  |
|--------------------------|-----------------------------------------------|
| DOM-based XSS            | `DOM Invader`, `XSStrike`, console analysis    |
| WebSocket issues         | `Burp`, `WS King`, `wscat`                     |
| GraphQL introspection    | `InQL`, `GraphQLmap`, `Altair`                 |
| HTTP Smuggling           | `Burp`, `smuggler.py`, `httpreqsmuggler`       |
| Web Cache Poisoning      | `Param Miner`, `Burp`                          |
| Prototype Pollution      | `pollution`, JS fuzzing                        |
| DNS Rebinding            | `singularity`, `dnsrebind-tool`               |
| Timing Attacks           | `ffuf`, `Burp`, manual delay payloads         |

---

## Continuous Improvement
- [ ] Document all findings (valid + invalid)
- [ ] Analyze false positives/negatives
- [ ] Share responsibly via writeups
- [ ] Update tools and wordlists regularly
- [ ] Participate in CTFs / red team exercises
- [ ] Study public bug reports: HackerOne, Bugcrowd, Intigriti
