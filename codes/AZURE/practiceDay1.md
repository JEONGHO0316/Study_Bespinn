# 기초 명령어 
```
#1. Azure CLI 버전 확인
az --version

#2. Azure CLI 수동 업그레이드
az upgrade

#3. Azure CLI 자동 업그레이드
az config set auto-upgrade.enable=yes

#3.1 업그레이드 중 사용자 확인 인터럽트 방지
az config set auto-upgrade.prompt=no

#4. 자동 업그레이드 해제
az config set auto-upgrade.enable=no

#5. Azure 로그인
az login --output table
az login -o table
az login --use-device-code

#6. Azure 로그아웃
az logout

#7. Azure 구독 목록 조회
az account list -o table

#8. Azure 구독 변경
az account set --subscription "MYSUBID"

#9. Azure 구독 정보 정리
az account clear

#10. Azure 공급자 확인
az provider show --namespace Microsoft.App | more

az provider show --namespace Microsoft.DataMigration -o table

#11. Azure 공급자 등록
    az provider register --namespace Microsoft.App

```

# PowerShell 명령어 연습
```
#PowerShell 명령의 기본 형식
Get-Service -Name w32time

#PowerShell 도움말 시스템
Get-Help -Name [-detailed | -examples | -full | -online]

Update-Help -Module ServerManager, Microsoft.PowerShell.LocalAccounts

Update-Help –UICulture ko-KR, en-US

Update-Help –SourcePath \\Server01\Share\Help -Credential JEONGHO # 오프라인으로 업데이트 가능 하게 업데이트는 최신 버전으로 하는게 좋다.

Save-Help –Module ServerManager -DestinationPath "C:\PowerShell_Lab\SavePSHelp" -Credential JEONGHO

#도움말 보는 방법
Get-Help -Name New-Alias -full

#PowerShell 명령을 찾고 빠르게 익히는 방법
Get-Command -Verb Get* -Noun Net*

Get-Help Get-NetAdapter -full

##개체
#개체의 멤버 확인 방법
Get-Process | get-Member –MemberType property, method # method 와 property 만 

Get-Process | get-Member –MemberType Properties # property 가 달린 건 다 

##파이프라인 시스템의 기본 개념
Get-Process | Out-File e:\process.txt

#둘 이상의 개체가 혼합된 파이프라인 출력
Get-ChildItem –Path C:\Windows | Get-Member

##명령의 파이프라인 지원 방식 
#ByValue를 사용한 바인딩
'Dhcp','EFS' | Get-Service

#ByPropertyName을 사용한 바인딩
Get-Service | Stop-Process

##개체 선택 
#명령의 결과 제한하기 
Get-Service | Select-Object –First 7 # 첫번째 부터 7개 
 
Get-Service | Select-Object –Last 7 # 마지막 에서 7개
 
Get-Service | Select-Object –skip 7 # 7개 제외하고 

Get-Process | Select-Object –index 0,3 # 첫번째 랑 네번째 출력 

Get-Process | Select-Object –index (3..6)  # 네번째 부터 일곱번째 출력 

Get-Process | gm 

#표시할 속성 지정 
Get-Process | Select-Object –Property Name,ID,PM,VM # 속성의 이름 , id , 

(Get-Process | Select-Object –Property Name,ID,PM,VM -Last 7)[0] # [0] 를 주면 하나만 컬렉션의 첫번째 값 

#사용자 지정 속성 사용하기
Get-ChildItem -Path C:\Users\Administrator\Downloads | Select-Object -Property Name,@{n='Size(MB)'; e={$PSItem.Length/1MB}}  # 해쉬 테이블로 표시되는 값과 이름을 바꿀 수 있음 

Get-Volume | Select-Object -Property DriveLetter,Size,SizeRemaining 

Get-Volume | Select-Object -Property DriveLetter, @{n='전체 크기(GB)';e={'{0:N2}'-f ($PSItem.Size/1GB)}}, @{n='남은 크기(GB)';e={'{0:N2}'-f ($PSItem.SizeRemaining/1GB)}}

# DriverLetter 기준으로 오름차순 정리 
Get-Volume |Select-Object -Property DriveLetter,  @{n='전체 크기(GB)';e={'{0:N2}' -f ($_.Size/1GB)}},  
 @{n='남은 크기(GB)';e={'{0:N2}' -f ($_.SizeRemaining/1GB)}} | Sort-Object DriveLetter

 # DriverLetter 기준으로 내림차순 정리 
Get-Volume |Select-Object -Property DriveLetter,  
@{n='전체 크기(GB)';e={'{0:N2}' -f ($_.Size/1GB)}},  @{n='남은 크기(GB)';e={'{0:N2}' -f ($_.SizeRemaining/1GB)}} | Sort-Object  DriveLetter -Descending 

##개체의 정렬과 계산 
#개체를 정렬하는 Sort-Object 
Get-Process | Sort-Object -Property workingset 

#개체 컬렉션을 계산하는 Measure-Object 
Get-Process | Measure-Object –Property PM –Sum -Average -Maximum  -minimum  # 속성의 평균 , 더한값 등등 계산 

"Hello PowerShell" | Measure-Object -Character -Line # 문자의 글자수 라인수 세는 
 
##개체 필터링 
#기본 필터링 기법
Get-Service | Where-Object -Property Status –eq Running

Get-Service | Where-Object -Property Name.Length –gt 7 # 기본 필터링은 2차 속성 까지 필터링을 해주지 않아 실행 안됨 

#고급 필터링 기법 
Get-Service | Where-Object -FilterScript {$PSItem.Name.Length -gt 7}
Get-Service | Where-Object {$_.Name.Length -gt 7}
Get-Service | ? {$_.Name.Length -gt 7} | select -last 7

Get-Volume | Where-Object –Filter { $PSItem.HealthStatus –ne 'Healthy' -or $PSItem.SizeRemaining –lt 100000000MB } 
```

# PowerShell 환경 에서 Azure 연습
```
#1. Azure PowerShell 설치
Install-module -Name Az -AllowClobber

#2. Azure 연결
Connect-AzAccount
#2.1 만약 스크립트 에러가 나오면 
 Get-ExecutionPolicy -ExecutionPolicy 
 Get-ExecutionPolicy -Executionpolicy RemoteSigned -scope CurrentUser

#3. Azure 구독 확인
Get-AzSubscription

#4. Azure 구독 선택
Select-AzSubscription -Subscription (Get-AzSubscription).Id
Select-AzSubscription -Subscription "Myid"

#5. 리소스 공급자 확인
# 테이블 형태로 나오게 하는 파워셸 명령어 
Get-AzResourceProvider -ProviderNamespace Microsoft.DataMigration | format -table 

#6. 리소스 공급자 등록
Register-AzResourceProvider -ProviderNamespace Microsoft.DataMigration
```

# AZ CLI VM 설치
```
# 리소스 그룹 생성 
az group create -l koreacentral -n rg-hallofarmor 
# 가상 네트워크 
az network vnet create -n vnet-hallofarmor-kr -g rg-hallofarmor --address-prefixes 172.16.0.0/16 --subnet-name snet-jarvis --subnet-prefixes 172.16.2.0/24 -o table 
```

# .ps 파일로 한번에 실행 
```
#0. 공통
$location = "koreacentral" # 자주활용 될거니까 변수 저장 / $를 쓸 때 powershell 에서는 $를 써야 변수 , linux에서는 공백 없고 $를 쓰면 안됨

#1. 리소스 그룹
$rg = $(az group list --query "[?contains(name, 'hall')].name" -o tsv) # 리소스 그룹 리스트 --query 는 뒷 내용을 필터링 하는 명령어, contains : 포함된 즉 hall이 포함된 그룹을 $rg에 담아라 담으려면 $ () 이런식으로 담아야함  

#2. 가상 네트워크
$vnet = $(az network vnet list --query "[?contains(name, 'hall')].name" -o tsv) # hall이 들어간 vnet 리스트를 $Vnet에 담아라 
$subnet = $(az network vnet subnet list -g $rg --vnet-name $vnet --query "[?contains(name, 'jarvis')].name" -o tsv) # $subnet에 jarvis가 들어간 리스트를 담아라 

#4. 네트워크 보안 그룹
az network nsg create -g $rg -n nsg-vmjarvisbe -l $location # 필수 값을 넣을때 변수 활용 / 종속성 없음

#5. 공용 IP 주소와 NSG가 연결된 가상 네트워크 카드 만들기
az network nic create -g $rg --vnet-name $vnet --subnet $subnet -n nic-02-vmjarvisbe --network-security-group nsg-vmjarvisbe # 필수 값  / 종속성 없음

#6. 가상 머신 만들기
az vm create -n vmjarvisbe -g $rg --admin-username tony --authentication-type ssh --generate-ssh-keys --image Ubuntu2204 --nics nic-02-vmjarvisbe --size Standard_DS1_v2 # image 목록 확인법 az vm image list -o table



#7. 가상 머신 연결 (컨트롤 VM에서)
ren $home\.ssh\id_rsa vmjarvisbe_key # 가상 머신 만들 때 기본 Default .pub 는 public 안붙으면 public 아님 vmjarvisbe_key -> public 아닌걸 이름 을 임의로 바꿈 리눅스는 확장자 .sh 윈도우는 .ps1
#$pvIp = $(az network nic list -g rg-hallofarmor --query "[?contains(name, 'nic-02')].ipConfigurations[].privateIPAddress" -o tsv)

#ssh -i ~/.ssh/vmjarvisbe_key tony@$pvIp

#8. NGINX 설치 및 샘플 페이지 생성
# 패키지 소스 업데이트
#sudo apt-get -y update

# NGINX 설치
#sudo apt-get -y install nginx

# index.html 파일 만들기
#sudo sh -c 'echo "Running Jarvis Foundation Models from host $(hostname)" > /var/www/html/index.html'
```

# .PS 파일로 IIS 서버 바로 설치 가능 
```
#0. 공통
$location = "koreacentral"
$TimeZone ="Korea Standard Time"

#1. 리소스 그룹
$rg = Get-AzResourceGroup -Name "rg-hallofarmor" -Location $location

#2. 가상 네트워크 3개가 한줄 한번에 실행 해야함 !  ` -> 어금악센트기호 이걸 쓰면 끝난게 아니고 이어진다 
$vnet = Get-AzVirtualNetwork `
  -ResourceGroupName $rg.ResourceGroupName `
  -Name "vnet-hallofarmor-kr"

#3. 공용 IP 주소 만들기
$pip = New-AzPublicIpAddress `
  -ResourceGroupName $rg.ResourceGroupName `
  -Location $location `
  -AllocationMethod Static `
  -IdleTimeoutInMinutes 4 `
  -Name "pip-vmjarvisfe"

#4. 네트워크 보안 그룹
#4.1 포트 3389에 대한 인바운드 네트워크 보안 그룹 규칙 만들기
$nsgRuleRDP = New-AzNetworkSecurityRuleConfig `
-Name "RDP"  `
-Protocol "Tcp" `
-Direction "Inbound" `
-Priority 1000 `
-SourceAddressPrefix * `
-SourcePortRange * `
-DestinationAddressPrefix * `
-DestinationPortRange 3389 `
-Access "Allow"

#4.2 포트 80에 대한 인바운드 네트워크 보안 그룹 규칙 만들기
$nsgRuleWeb = New-AzNetworkSecurityRuleConfig `
-Name "WWW"  `
-Protocol "Tcp" `
-Direction "Inbound" `
-Priority 1001 `
-SourceAddressPrefix * `
-SourcePortRange * `
-DestinationAddressPrefix * `
-DestinationPortRange 80 `
-Access "Allow"

#4.3 네트워크 보안 그룹 만들기
$nsg = New-AzNetworkSecurityGroup `
-ResourceGroupName $rg.ResourceGroupName `
-Location $location `
-Name "nsg-vmjarvisfe" `
-SecurityRules $nsgRuleRDP,$nsgRuleWeb

#5. 공용 IP 주소와 NSG가 연결된 가상 네트워크 카드 만들기
$nic = New-AzNetworkInterface `
  -Name "nic-01-vmjarvisfe" `
  -ResourceGroupName $rg.ResourceGroupName `
  -Location $location `
  -SubnetId $vnet.Subnets[0].Id `
  -PublicIpAddressId $pip.Id `
  -NetworkSecurityGroupId $nsg.Id
  
#6. 가상 머신 구성 
#6.1 자격증명 객체 정의 #pass word 같은 
$securePassword = ConvertTo-SecureString 'Pa55w.rdBSAz' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("tony", $securePassword)

#6.2 가상 머신 구성 만들기
$vmConfig = New-AzVMConfig `
  -VMName "vmjarvisfe" `
   -VMSize "Standard_B2ms" `
   -SecurityType "TrustedLaunch" | `
Set-AzVMOperatingSystem `
  -Windows `
  -ComputerName "vmjarvisfe" `
  -Credential $cred `
  -TimeZone $TimeZone | `
Set-AzVMSourceImage `
  -PublisherName "MicrosoftWindowsServer" `
  -Offer "WindowsServer" `
  -Skus "2019-Datacenter-gensecond" `
  -Version "latest" | `
Add-AzVMNetworkInterface `
  -Id $nic.Id | `
Set-AzVMBootDiagnostic -Disable

#4. VM 배포
New-AzVM `
  -ResourceGroupName $rg.ResourceGroupName `
  -Location $location -VM $vmConfig


# 위에꺼 다 한후에 아래 주석 지워야함 
#5. VM 공용 IP 확인
#$PubIp = (Get-AzPublicIpAddress -Name pip-vmjarvisfe).IpAddress   

#6. VM SSH 연결
#mstsc /v:$PubIp

#7. IIS 설치 및 샘플 페이지 생성
#Install-WindowsFeature -Name Web-Server -IncludeManagementTools
#Set-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value "Running JARVIS Web Service from host $($env:computername) !"
```