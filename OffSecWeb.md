# XSS

```
  - It allows attackers to inject malicious scripts into websites.
  - These scripts then run in the browser of other users who visit that website.
  - The attacker can steal information, manipulate the website’s content, or even take control of a user’s session.
  - Medium Risk ( low impact + high probability = medium risk )



```


What is XSS (Cross-Site Scripting)? 🤔
XSS is a type of security vulnerability in web applications that allows attackers to inject malicious scripts into websites. These scripts then run in the browser of other users who visit that website. The attacker can steal information, manipulate the website’s content, or even take control of a user’s session.

💡 Think of XSS like this:
Imagine you go to a public notice board and post a note. Normally, people can only read it. But what if someone adds a hidden, harmful message that only gets triggered when others interact with the board? That’s what XSS does to websites.

📋 Types of XSS:
Stored XSS (Persistent):

Malicious code is saved on the website’s server (e.g., in comments or profiles).
Example: An attacker writes harmful JavaScript in a comment box, and every visitor sees the harmful script.
Reflected XSS:

The malicious script is included in a URL or form input.
Example: An attacker sends a link with malicious code, and if the victim clicks it, the script runs.
DOM-based XSS:

Happens when the client-side script processes untrusted data.
Example: A website’s JavaScript dynamically updates the page using URL parameters without validation.
🛠 Simple Example of XSS Attack:
Suppose a website has a comment section, and instead of posting a normal comment, an attacker writes:

html
Copy code
<script>alert('Hacked!');</script>
Now, every visitor who loads that comment will see a pop-up saying "Hacked!" in their browser.

🎯 Why is XSS Dangerous?
Steal cookies and session tokens (can take over user accounts).
Redirect users to malicious websites.
Modify the website’s content.
Spread malware.