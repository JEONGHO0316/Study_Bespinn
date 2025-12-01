### Amazon Linux 용 userdata
```
#!/bin/bash
yum -y install httpd 
systemctl enable httpd 
systemctl restart httpd 
    
echo '<html><h1>Hello From your Linux Web Server!</h1></html>' > /var/www/html/index.html
```

### Ubuntu 용 userdata 
```
#!/bin/bash
apt update
apt install -y apache2
systemctl enable apache2
systemctl restart apache2    
echo '<html><h1>Hello From your test Web Server!</h1></html>' > /var/www/html/index.html

```