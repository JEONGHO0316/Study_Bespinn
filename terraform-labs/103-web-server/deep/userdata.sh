#!/bin/bash
yum -y install httpd 
systemctl enable httpd 
systemctl restart httpd 
    
echo '<html><h1>Hello From your Linux Web Server!</h1></html>' > /var/www/html/index.html
