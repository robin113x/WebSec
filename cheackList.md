
## Comprehensive Bug Bounty Checklist (Basic Advanced)
### 1. Information Gathering
**Basic**
- Subdomain enumeration (passive: crt.sh, amass, assetfinder)
- DNS records analysis (A, MX, TXT, NS, CNAME)
- Technology stack identification (WhatWeb, Wappalyzer)
- WHOIS info and IP range mapping
- Robots.txt / sitemap.xml analysis
  
**Intermediate**
- Cloud provider detection (AWS, GCP, Azure signatures)
- Historical data (Wayback Machine, gau, hakrawler)
- JavaScript file parsing (for endpoints, secrets)
- GitHub/GitLab repo analysis (dorks, token leaks)
  
**Advanced**
- Employee info for OSINT/social engineering (if in-scope)
- ASN-based enumeration (bgp.he.net)
- Certificate transparency logs
- Correlate CDN/WAF behavior across assets
### 2. Authentication Testing
**Basic**
- Test login for rate limiting/brute force protection
- Check for default credentials
- Password policy assessment
  
**Intermediate**
- MFA implementation analysis (TOTP, SMS, bypass vectors)
- Session management flaws (token reuse, logout bypass)
Comprehensive Bug Bounty Checklist (Basic to Advanced)
- Account enumeration (forgot password, login error messages)
  
**Advanced**
- JWT vulnerabilities (none algorithm, `kid` injection)
- OAuth misconfigurations (redirect URI, token leakage)
- SSO integrations (SAML, OpenID Connect bypass)
- Password reset flow logic testing
### 3. Authorization Testing
**Basic**
- IDOR (parameter manipulation)
- Horizontal privilege escalation
  
**Intermediate**
- Missing function-level access control
- API endpoint access between user roles
- Privilege escalation (vertical access)
  
**Advanced**
- JWT claims tampering
- Business logic-based authorization bypass
- Scope manipulation in OAuth tokens
### 4. Input Validation Testing
**Basic**
- Reflected XSS
- Basic SQL Injection
- Open Redirects
  
**Intermediate**
- Stored/DOM XSS
- Command Injection
- SSRF (via URL parameters, headers)
- File upload bypass (extension filtering, content-type spoofing)
  
**Advanced**
- XXE (with DTDs, SSRF chaining)
- SSTI (Jinja2, Twig, etc.)
- HTTP header injection
- HTTP parameter pollution
- WebSocket input validation
### 5. Configuration Testing
**Basic**
- Directory listing check
- Default credentials or setup pages
- Missing security headers (CSP, X-Frame-Options)
  
**Intermediate**
- CORS misconfigurations
- Verbose error messages
- HTTP methods allowed (OPTIONS, TRACE)
  
**Advanced**
- Cookie attributes (Secure, HttpOnly, SameSite)
- Clickjacking vulnerabilities
- CSRF (token-less or predictable token logic)
  
### 6. Business Logic Testing
**Basic**
- Check for negative values
- Bypass validation (client-side)
  
**Intermediate**
- Price/quantity manipulation
- Workflow bypass (e.g., skipping payment)
  
**Advanced**
- Race conditions
- Abuse of referral programs/free trials
- Time-based privilege escalation (delayed access unlocks)
### 7. API Testing
**Basic**
- Fuzz public API for typical input validation bugs
- Check for authentication and basic rate limiting
  
**Intermediate**
- Broken object-level authorization
- Excessive data exposure (verbose error messages, debug info)
- Mass assignment (check for hidden fields)
  
**Advanced**
- GraphQL-specific flaws (introspection, query batching)
- Improper asset management (deprecated endpoints)
- JWT usage in APIs (authorization logic)
### 8. Mobile-Specific Testing
**Basic**
- Insecure data storage (SQLite, plist, etc.)
- Insecure communication (HTTP, certificate pinning bypass)
  
**Intermediate**
- Reverse engineering APK/IPA
- Debug info or logs in production builds
Comprehensive Bug Bounty Checklist (Basic to Advanced)

**Advanced**
- Code tampering
- Dynamic analysis (Frida, objection)
- Abuse of exposed activities/intents
  
### 9. Post-Exploitation
**Basic**
- Identify sensitive data exposed
- Validate impact level
  
**Intermediate**
- Check for privilege escalation opportunities
- Access internal services/assets (pivoting)
  
**Advanced**
- Persistence mechanisms
- Payload delivery via chained vulnerabilities
- Internal lateral movement (SSRF > RCE > internal recon)
  
## Advanced Techniques
- DOM-based XSS: sink/source tracing
- WebSocket testing: auth checks, schema fuzzing
- GraphQL: introspection, alias/fragment abuse
- HTTP Smuggling: CL.TE, TE.CL variants
- Web Cache Poisoning: host header/parameter-based
- Prototype pollution (JS object traversal)
- DNS rebinding attacks
- Timing attacks (authorization logic, secrets)
## Continuous Improvement
- Log all findings (valid + invalid)
- Analyze false positives & bypasses
- Share responsibly via writeups/bug bounty reports
- Update recon & fuzzing tools regularly
- Participate in CTFs / Red vs Blue
- Learn from public reports (HackerOne, Bugcrowd, Intigriti)
