
```
Install-WindowsFeature -name web-Server -IncludeManagementTools

Set-Content -Path "C:\inetpub\wwwroot\deFault.htm" -value "Runnig Jarvis built on Copilot from host $($env:COMPUTERNAME) !"

mkdir .ssh
ssh -i .ssh\vmjarvisbe_key.pem tony@172.16.1.6

sudo apt-get update 
sudo apt-get -y install nginx
sudo sh -c 'echo "Runnig Jarvis Faundation Models from host $(hostname)" > /var/www/html/index.html'

>ssh -i mytest_key.pem tony@10.0.3.99 -p 221 
```