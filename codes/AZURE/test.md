
```

윈도우 서버에서 웹 서버 설치 후 따로 설정 

Install-WindowsFeature -name web-Server -IncludeManagementTools

Set-Content -Path "C:\inetpub\wwwroot\deFault.htm" -value "Runnig Jarvis built on Copilot from host $($env:COMPUTERNAME) !"
-------------------------------------------
.ssh 폴더 먼저 생성 후 키를 이용해서 ssh 접속 
mkdir .ssh
ssh -i .ssh\vmjarvisbe_key.pem tony@172.16.1.6

리눅스의 웹서버인 nginx 설치후
ssh 를 이용해서 접속

sudo apt-get update 
sudo apt-get -y install nginx
sudo sh -c 'echo "Runnig Jarvis Faundation Models from host $(hostname)" > /var/www/html/index.html'

>ssh -i mytest_key.pem tony@10.0.3.99 -p 221 
```