## ✅ How to Use host-header-checker.sh
```

chmod +x host-header-checker.sh
./host-header-checker.sh https://any.com/reset_password

```
### OUTPUT
```
[+] Method 1: Host => bing.com
Status: 302
Location: https://bing.com/reset_password?code=abc123

[+] Method 2: Host => bing.com, X-Forwarded-Host => realweb.com
Status: 200

[+] Method 3: Host => realweb.com, X-Forwarded-Host => bing.com
Status: 302
Location: https://bing.com/reset_password?code=xyz999
```
<hr>
