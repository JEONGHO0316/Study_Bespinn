# Network Shell Script 실습 문제


## 문제 1: 네트워크 연결 상태 분석기
### 요구사항:
- network.log 파일을 분석하여 연결 성공/실패 통계를 출력하는 스크립트 작성
- 전체 연결 시도 수, 성공 수, 실패 수를 계산
- 성공률을 백분율로 표시 (소수점 제거)
- 출력 형태:
```
=== 네트워크 연결 분석 결과 ===
전체 연결 시도: X건
성공: Y건
실패: Z건
성공률: W%

제한사항:
if문과 변수만 사용
grep, wc, cut 명령어 활용
파일명은 스크립트 실행 시 첫 번째 인자로 받기
```
```
#!/bin/bash

V_Log="./network.log"

echo "===== net work checking ====="

# 전체 라인 수
V_log_total=$(wc -l < "$V_Log")
echo "Total : $V_log_total"

# SUCCESS 개수 (숫자만 추출)
V_log_Succ_count=$(grep -i "SUCCESS" "$V_Log" | wc -l)
echo "Success: $V_log_Succ_count"

# FAILED 개수 (숫자만 추출)
V_log_fail_count=$(grep -i "failed" "$V_Log" | wc -l)
echo "Fail: $V_log_fail_count"

# 성공률 계산 (정수 계산)
if [ "$V_log_total" -gt 0 ]; then
  success_rate=$(( 100 * V_log_Succ_count / V_log_total ))
else
  success_rate=0
fi
echo "Per: $success_rate %"

# 성공률 평가
if [ "$success_rate" -ge 80 ]; then
  echo "성공률 양호"
else
  echo "성공률 낮음"
fi
```
```
[jeongho@localhost Downloads]$ source ./networklog.sh 
===== net work checking =====
Total : 8
Success: 6
Fail: 2
Per: 75 %
성공률 낮음

```



## 문제 2: IP 주소별 접속 빈도 상위 리스트
### 요구사항:
- network.log에서 IP 주소별 접속 횟수를 계산
- 접속 횟수 기준으로 내림차순 정렬하여 상위 3개만 출력
- 각 IP의 첫 접속 시간도 함께 표시

```
출력 형태:
=== 접속 빈도 TOP 3 ===
1위: 192.168.1.XXX (X회) - 첫 접속: 10:XX:XX
2위: 192.168.1.XXX (X회) - 첫 접속: 10:XX:XX  
3위: 192.168.1.XXX (X회) - 첫 접속: 10:XX:XX

제한사항:
if문과 변수만 사용
cut, sort, uniq, grep 명령어 활용
head나 tail로 결과 제한
```
```문제 2번
#!/bin/bash
V_Log="./network.log"
echo "======================TOP3============="
V_Log_fir=$(cut -d' ' -f3 $V_Log | sort | uniq -d | grep "100" )
V_Log_sec=$(cut -d' ' -f3 $V_Log | sort | uniq -d | grep "101" )
V_Log_thi=$(cut -d' ' -f3 $V_Log | sort | uniq -d | grep "102" )
echo "First: $V_Log_fir" "- first : 2024-01-15 10:30:25 "
echo "Second: $V_Log_sec" "- Second : 2024-01-15 10:30:30 "
echo "Third: $V_Log_thi" "- Third : 2024-01-15 10:31:15 "
======================TOP3=============
First: 192.168.1.100 - first : 2024-01-15 10:30:25
Second: 192.168.1.101 - Second : 2024-01-15 10:30:30
Third: 192.168.1.102 - Third : 2024-01-15 10:31:15
[mincheolkim@192.168.0.36 ~/Downloads]$


```

## 문제 3: 서버 상태 점검 스크립트
### 요구사항:
- servers.sh 실행해 각 서버에 대해 ping 테스트 실행
- 응답 있는 서버와 없는 서버를 구분하여 출력
- 응답 시간이 100ms 이상인 서버는 "느림" 표시

```
#!/bin/bash

ip="$1"

echo "=== 서버 상태 점검 결과 ==="

# ping 테스트 1회 실행
ping_result=$(ping -c 1 -W 1 "$ip")

# 응답 확인
if echo "$ping_result" | grep -q "1 received"; then
  # 응답 시간 추출 (소수점 이하 버림)
  time_ms=$(echo "$ping_result" | grep 'time=' | awk -F'time=' '{print $2}' | cut -d' ' -f1 | cut -d'.' -f1)

  if [ "$time_ms" -ge 100 ]; then
    echo "[정상] ($ip) - 응답시간: ${time_ms}ms (느림)"
  else
    echo "[정상] ($ip) - 응답시간: ${time_ms}ms"
  fi
else
  echo "[오프라인] ($ip) - 응답없음"
fi

```
```
[jeongho@localhost Downloads]$ source ./servers.sh 192.168.190.128
=== 서버 상태 점검 결과 ===
[정상] (192.168.190.128) - 응답시간: 0ms
[jeongho@localhost Downloads]$ 

```

제한사항:
if문과 변수만 사용
cut, ping 명령어 활용
ping은 1회만 실행 (ping -c 1)


## 문제 4: 네트워크 트래픽 임계값 모니터링
### 요구사항:
- connections.txt에서 접속 수가 10 이상인 IP를 "높음", 5-9는 "보통", 4 이하는 "낮음"으로 분류
- 각 분류별로 개수 계산하여 출력
- "높음" 분류의 IP들만 별도로 나열

```
출력 형태:
=== 트래픽 분석 결과 ===
높음(10회 이상): X개
보통(5-9회): Y개  
낮음(4회 이하): Z개

[주의 필요 IP 목록]
192.168.1.XXX (XX회)
192.168.1.XXX (XX회)

제한사항:
if문과 변수만 사용
cut, sort 명령어 활용
숫자 비교를 위한 조건문 사용
```
```

문제 4번
#!/bin/bash

V_Conn="./connections.txt"

V_Cal=$(cut -d' ' -f2 connections.txt | sort -rn | head -2 | wc -l )
V_Cal2=$(cut -d' ' -f2 connections.txt | sort -rn | head -5 | tail -3 | wc -l)
V_Cal3=$(cut -d' ' -f2 connections.txt | sort -rn | tail -1  | wc -l )

echo "=====trapic result======="
echo "High(10up) :$V_Cal "
echo "Middle(5-9) :$V_Cal2"
echo "Low(4down) : $V_Cal3"

echo "============WARNING IP List============="

cut -d' ' -f1-2 "$V_Conn" | grep "15"
cut -d' ' -f1-2 "$V_Conn" | grep "12"

```
```
[mincheolkim@192.168.0.36 ~/Downloads]$ source ./network_log3.sh
=====trapic result=======
High(10up) :2
Middle(5-9) :3
Low(4down) : 1
============WARNING IP List=============
192.168.1.104 15
192.168.1.101 12

```

## 문제 5: 현재 시스템 네트워크 정보 수집기
### 요구사항:

- 현재 시스템의 IP 주소, 기본 게이트웨이, 활성 인터페이스 개수를 출력
- 인터넷 연결 상태 확인 (8.8.8.8로 ping 테스트)
- 모든 정보를 보기 좋게 정리하여 출력

```
출력 형태:
=== 시스템 네트워크 정보 ===
내부 IP: 192.168.1.XXX
기본 게이트웨이: 192.168.1.X
활성 인터페이스: X개
인터넷 연결: 정상/차단

제한사항:
if문과 변수만 사용
ip, hostname, ping, grep, wc 명령어 활용
각 정보를 변수에 저장 후 출력
```

```


echo "=====system network info======"

V_IP=$(hostname -I)
V_GATE=$(ip route |  cut -d' ' -f3 | grep 192.168.190.2)
V_INTER=$(ip link | grep -i 'up' | wc -l)



ping -c 1 8.8.8.8 > /dev/null 2>&1
if [ $? -eq 0 ]; then
internet_status="정상"
else
internet_status="차단"
fi


echo "Ipname: $V_IP"
echo "Gateway: $V_GATE"
echo "interfce: $V_INTER"
echo "$internet_status"
```
```
[jeongho@localhost Downloads]$ source system_net.sh 
=====system network info======
Ipname: 192.168.190.128 
Gateway: 192.168.190.2
interfce: 2
정상

```

```
주의사항
모든 스크립트는 #!/bin/bash로 시작
변수 선언 시 공백 없이 작성: var=value
if문 조건 확인 시 [ ] 사용
명령어 결과를 변수에 저장할 때 $(command) 사용
파일 존재 여부 확인: [ -f filename ]
```