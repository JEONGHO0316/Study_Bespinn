### Ubuntu 용 userdata
```
#!/bin/bash
apt update
apt install -y apache2
sed -i 's/Listen 80/Listen ${server_ports}/' /etc/apache2/ports.conf
systemctl enable apache2
systemctl restart apache2    
echo '<html><h1>Hello From your Ubuntu Web Server runnig on port : ${server_ports}!</h1></html>' > /var/www/html/index.html

```
### Amazon Linux 용 userdata
```
#!/bin/bash
yum -y install httpd 
sed -i 's/Listen 80/Listen ${port_number}/' /etc/httpd/conf/httpd.conf
systemctl enable httpd 
systemctl restart httpd 
echo '<html><h1>Hello From My Linux Web Server ruuning on port ${port_number}!</h1></html>' > /var/www/html/index.html
```
