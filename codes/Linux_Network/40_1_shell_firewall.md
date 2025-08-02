# 🧪 문제 1: 특정 IP 차단 상태 확인 후 차단 설정
## ✅ 실행 예시
```
$ sudo ./problem1.sh )
[INFO] 현재 rich rule 목록에 192.168.0.100 차단 룰이 존재하지 않습니다.
[INFO] 차단 룰을 추가합니다...
success

또는
$ sudo ./problem1.sh 192.168.0.100
[INFO] 192.168.0.100은 이미 차단되어 있습니다.
[SKIP] 추가 작업을 수행하지 않습니다.
```
```
[jeongho@192.168.0.47 ~/quest]$ sudo bash problem99.sh 192.168.0.34
[INFO] 현재 rich rule 목록에 192.168.0.34 차단 룰이 존재하지 않습니다.
[INFO] 차단 룰을 추가합니다...
success
success
success
[jeongho@192.168.0.47 ~/quest]$ sudo bash problem99.sh 192.168.0.36
[INFO] 192.168.0.36 은 이미 차단되어 있습니다.
[SKIP] 추가 작업을 수행하지 않습니다.
```


```
#!/bin/bash

port="$1"

if [ -z "$(sudo firewall-cmd --list-rich-rules | grep "$port")" ]; then

        echo "[INFO] 현재 rich rule 목록에 $port 차단 룰이 존재하지 않습니다."
        echo "[INFO] 차단 룰을 추가합니다..."
        sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='$port' reject"
        sudo firewall-cmd --reload
        echo "success"

else

        echo "[INFO] $port 은 이미 차단되어 있습니다."
        echo "[SKIP] 추가 작업을 수행하지 않습니다."
fi
```



# 🔒 문제 2: 포트 8080이 열려 있다면 닫기
## ✅ 실행 예시

```
$ sudo ./problem2.sh 8080/tcp
[INFO] 포트 8080/tcp 이 열려 있습니다. 제거합니다...
success

또는
$ sudo ./problem2.sh 8080/tcp
[INFO] 포트 8080/tcp 이 열려 있지 않습니다. 아무 작업도 수행하지 않습니다.
```

```
[jeongho@192.168.0.47 ~/quest]$ sudo bash problem88.sh 8000 
8000/tcp
[INFO] 포트 8000/tcp 이 열려 있습니다. 제거합니다...
success
success
sucess
[jeongho@192.168.0.47 ~/quest]$ sudo firewall-cmd --list-ports
```


```
#!/bin/bash

port="$1"

if sudo firewall-cmd --list-ports | grep "$port" 2> /dev/null ; then

        echo "[INFO] 포트 8000/tcp 이 열려 있습니다. 제거합니다..."
        sudo firewall-cmd --permanent --remove-port=8000/tcp
        sudo firewall-cmd --reload

        echo "sucess"

else
        echo "[INFO] 포트 8000/tcp 이 열려 있지 않습니다. 아무 작업도 수행하지 않습니다."

fi
```

