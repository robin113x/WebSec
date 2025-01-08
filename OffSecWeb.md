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

php
https://example.com/#<script>alert('DOM XSS');</script>
Or test in the input fields:
```
```
<input type="text" onfocus="alert('XSS')">

🚩 Look for JavaScript Functions
Check if the website uses functions like innerHTML, document.write(), or eval().