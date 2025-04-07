#!/bin/bash

# Usage: ./host-header-checker.sh https://targetdomain.com/reset_password

TARGET_URL=$1

if [[ -z "$TARGET_URL" ]]; then
  echo "Usage: $0 <url>"
  exit 1
fi

echo "Testing Host Header Injection on: $TARGET_URL"
echo "----------------------------------------------"

# Method 1: Host header replaced with bing.com
echo -e "\n[+] Method 1: Host => bing.com"
curl -s -o /tmp/resp1.txt -w "Status: %{http_code}\n" \
  -H "Host: bing.com" \
  "$TARGET_URL"
grep -i "Location:" /tmp/resp1.txt

# Method 2: Host => bing.com, X-Forwarded-Host => realweb.com
echo -e "\n[+] Method 2: Host => bing.com, X-Forwarded-Host => realweb.com"
curl -s -o /tmp/resp2.txt -w "Status: %{http_code}\n" \
  -H "Host: bing.com" \
  -H "X-Forwarded-Host: realweb.com" \
  "$TARGET_URL"
grep -i "Location:" /tmp/resp2.txt

# Method 3: Host => realweb.com, X-Forwarded-Host => bing.com
echo -e "\n[+] Method 3: Host => realweb.com, X-Forwarded-Host => bing.com"
curl -s -o /tmp/resp3.txt -w "Status: %{http_code}\n" \
  -H "Host: realweb.com" \
  -H "X-Forwarded-Host: bing.com" \
  "$TARGET_URL"
grep -i "Location:" /tmp/resp3.txt

echo -e "\n[✓] Done. Check for suspicious redirections or usage of forged domains in Location headers."
