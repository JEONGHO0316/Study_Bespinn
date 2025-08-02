# 🐧 리눅스 텍스트 처리 명령어 실습 - 내 명령어 정리

## 문제 1: wc 명령어 활용

### 1-1. employees.txt 파일의 총 라인 수
```shell
[jeongho@localhost text_processing_practice]$ wc -l employees.txt 
5 employees.txt
```
### 1-2. system.log 파일의 단어 수와 문자 수
```shell
[jeongho@localhost text_processing_practice]$ wc -wm system.log 
 44 319 system.log
 ```

### 1-3. 현재 디렉토리의 모든 .txt 파일들의 라인 수
```
[jeongho@localhost text_processing_practice]$ wc -l *.txt
  5 employees.txt
  6 fruits.txt
  7 operating_systems.txt
  7 scores.txt
```

## 문제 2: sort 명령어 활용

### 2-1. fruits.txt 알파벳 정렬
```shell
[jeongho@localhost text_processing_practice]$ sort  fruits.txt 
apple
apple
banana
banana
cherry
date

```
### 2-2. scores.txt 내림차순 정렬
```shell
[jeongho@localhost text_processing_practice]$ sort -n scores.txt 
25
50
75
100
150
200
300
```

### 2-3. employees.txt 나이 기준 정렬
```
[jeongho@localhost text_processing_practice]$ sort -t: -k2  employees.txt 
Sara:22:Seoul:Designer
John:25:Seoul:Engineer
Lisa:28:Seoul:Analyst
Mike:30:Busan:Manager
Tom:35:Daegu:Developer

```

## 문제 3: uniq 명령어 활용

### 3-1. 중복 제거한 과일 목록
```shell
[jeongho@localhost text_processing_practice]$ sort fruits.txt |  uniq -uc 
      1 cherry
      1 date
```

### 3-2. 운영체제별 등장 횟수
```
[jeongho@localhost text_processing_practice]$ sort operating_systems.txt | uniq -c 
      3 Linux
      1 MacOS
      1 Unix
      2 Windows

```

### 3-3. 가장 많이 나타난 과일
```
[jeongho@localhost text_processing_practice]$ sort fruits.txt | uniq -d
apple
banana
```

## 문제 4: grep 명령어 활용

### 4-1. ERROR가 포함된 라인
```
[jeongho@localhost text_processing_practice]$ grep -i "ERROR" system.log 
2024-01-15 09:35 ERROR Database connection failed
2024-01-15 09:50 ERROR File not found: config.xml
[jeongho@localhost text_processing_practice]$ 
```

### 4-2. ERROR 또는 WARNING 포함된 라인 (라인 번호 포함)
```shell

[jeongho@localhost text_processing_practice]$ grep -in "ERROR" system.log && grep -in "WARNING" system.log 
2:2024-01-15 09:35 ERROR Database connection failed
5:2024-01-15 09:50 ERROR File not found: config.xml
3:2024-01-15 09:40 WARNING Memory usage high (85%)
6:2024-01-15 09:55 WARNING Disk space low

```

### 4-3. Seoul 거주 직원 정보
```
[jeongho@localhost text_processing_practice]$ grep -irn "Seoul"
employees.txt:1:John:25:Seoul:Engineer
employees.txt:3:Sara:22:Seoul:Designer
employees.txt:5:Lisa:28:Seoul:Analyst 

```

### 4-4. .txt 파일에서 "Linux" 검색 (대소문자 무시)
```
[jeongho@localhost text_processing_practice]$ grep -i "Linux"  *.txt
operating_systems.txt:Linux
operating_systems.txt:Linux
operating_systems.txt:Linux
```

## 문제 5: cut 명령어 활용

### 5-1. 직원 이름만 추출
```
[jeongho@localhost text_processing_practice]$ cut -d: -f1 employees.txt 
John
Mike
Sara
Tom
Lisa
```

### 5-2. 도시와 직책만 추출
```
[jeongho@localhost text_processing_practice]$ cut -d: -f3-4 employees.txt 
Seoul:Engineer
Busan:Manager
Seoul:Designer
Daegu:Developer
Seoul:Analyst

```

### 5-3. system.log의 시간 부분 추출
```
[jeongho@localhost text_processing_practice]$ cut -d' ' -f2 system.log 
09:30
09:35
09:40
09:45
09:50
09:55
10:00

```

## 문제 6: tr 명령어 활용

### 6-1. 대문자 → 소문자 변환
```
[jeongho@localhost text_processing_practice]$ echo "Hello World Linux" | tr "HWL" "hwl"
hello world linux
```

### 6-2. 콜론(:)을 탭으로 변환
```
[jeongho@localhost Downloads]$ cat employees.txt |  tr ":" "\n"
John
25
Seoul
Engineer
Mike
30
Busan
Manager
Sara
22
Seoul
Designer
```

### 6-3. 하이픈(-) 제거
```
[jeongho@localhost text_processing_practice]$ echo "Linux-System-Adminstreation" | tr "-" " " 
Linux System Adminstreation
```

## 문제 7: tail 명령어 활용

### 7-1. system.log 마지막 3줄
```
[jeongho@localhost text_processing_practice]$ tail -n3 system.log 
2024-01-15 09:50 ERROR File not found: config.xml
2024-01-15 09:55 WARNING Disk space low
2024-01-15 10:00 INFO System backup started
```

### 7-2. scores.txt 마지막 5개
```
[jeongho@localhost text_processing_practice]$ tail -n5 scores.txt 
200
150
75
300
25
```

## 문제 8: diff 명령어 활용

### 8-1. 파일 차이점
```
[jeongho@localhost text_processing_practice]$ diff  fruits_v1.txt fruits_v2.txt 
2c2
< banana
---
> orange
3a4
> grape

```

### 8-2. Unified 형식 차이점
```
[jeongho@localhost text_processing_practice]$ diff -u fruits_v1.txt fruits_v2.txt 
--- fruits_v1.txt	2025-07-22 17:24:06.570098995 +0900
+++ fruits_v2.txt	2025-07-22 17:24:06.570098995 +0900
@@ -1,3 +1,4 @@
 apple
-banana
+orange
 cherry
+grape

```

## 문제 9: 파이프라인 활용

### 9-1. Seoul 거주 직원 이름만 추출
```
[jeongho@localhost text_processing_practice]$ cat employees.txt | grep -i "SEOUL" | cut -d: -f1-2 
John:25
Sara:22
Lisa:28
```
### 9-2. 에러 및 경고 총 개수
```
[jeongho@localhost text_processing_practice]$ cat system.log | grep -in "ERROR" system.log && grep -in "WARNING" system.log | sort  | uniq -c
2:2024-01-15 09:35 ERROR Database connection failed
5:2024-01-15 09:50 ERROR File not found: config.xml
      1 3:2024-01-15 09:40 WARNING Memory usage high (85%)
      1 6:2024-01-15 09:55 WARNING Disk space low
```


### 9-4. 최고령 직원의 이름
```
[jeongho@localhost text_processing_practice]$ sort -t: -k2 employees.txt | tail -1
Tom:35:Daegu:Developer

```

## 문제 10: 리다이렉션 활용

### 10-1. fruits.txt 역순 정렬 후 저장
```
[jeongho@localhost text_processing_practice]$ sort -r fruits.txt 1>> fruits_reverse.txt
[jeongho@localhost text_processing_practice]$ cat fruits_reverse.txt 
date
cherry
banana
banana
apple
apple
```

### 10-2. Seoul 직원만 저장
```
[jeongho@localhost text_processing_practice]$ sort -r -t: -k3 employees.txt | tail | grep -i "seoul" >> seoul_employees.txt
```

### 10-3. 에러 메시지만 저장
```
[jeongho@localhost text_processing_practice]$ grep -i "error" system.log  >> errors.txt
[jeongho@localhost text_processing_practice]$ cat errors.txt 
2024-01-15 09:35 ERROR Database connection failed
2024-01-15 09:50 ERROR File not found: config.xml

```

## 문제 11: 종합 문제

### 11-1. 도시별 직원 수 내림차순 정렬
```
[jeongho@localhost text_processing_practice]$ sort -t: -k3 -r employees.txt | uniq -u
John:25:Seoul:Engineer
Sara:22:Seoul:Designer
Lisa:28:Seoul:Analyst
Tom:35:Daegu:Developer
Mike:30:Busan:Manager
```

### 11-2. 시간대별 로그 개수
```
[jeongho@localhost text_processing_practice]$ sort  -t: -k4 system.log | wc -l
7
```

### 11-4. .txt 파일에서 가장 많이 쓰인 단어 Top 5
```
[jeongho@localhost text_processing_practice]$ cat *.txt | sort -n | uniq -dc | sort -n | tail -5 | sort -r
      6 apple
      5 banana
      4 cherry
      3 Sara:22:Seoul:Designer
      3 Lisa:28:Seoul:Analyst

```

## 문제 12: 실무 시나리오

### 12-1. 가장 많이 접속한 IP
```
[jeongho@localhost text_processing_practice]$ sort -t. -k4 access.log | uniq -c
      1 192.168.1.10 - - [15/Jan/2024:10:30:00] GET /index.html 200
      1 192.168.1.10 - - [15/Jan/2024:10:32:00] GET /about.html 404
      1 192.168.1.10 - - [15/Jan/2024:10:34:00] GET /contact.html 200
      1 192.168.1.20 - - [15/Jan/2024:10:31:00] POST /login 200
      1 192.168.1.30 - - [15/Jan/2024:10:33:00] GET /index.html 200
[jeongho@localhost text_processing_practice]$
 ```

### 12-2. /home 사용자의 ID만 정렬
```
[jeongho@localhost home]$ sort -t: -k1 /etc/passwd | cut -d: -f1 
adm
alice
avahi
bin
bob
charlie
chrony
clevis

```

### 12-3. employees.txt 백업 → 수정 → 비교

# 백업
```bash
[jeongho@localhost text_processing_practice]$ mv employees.txt employees_backup.txt
```
# 수정
```
[jeongho@localhost text_processing_practice]$ echo "DHDHDH" 1 >> employees.txt 
```
# 비교
```
[jeongho@localhost text_processing_practice]$ diff -u  employees_backup.txt employees.txt
--- employees_backup.txt	2025-07-22 18:21:21.406805649 +0900
+++ employees.txt	2025-07-22 18:22:06.559563960 +0900
@@ -3,3 +3,4 @@
 Sara:22:Seoul:Designer
 Tom:35:Daegu:Developer
 Lisa:28:Seoul:Analyst
+DHDHDH 1
```