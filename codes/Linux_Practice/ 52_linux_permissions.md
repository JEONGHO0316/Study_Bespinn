# Linux 권한 관리 실습 문제
## 실습 환경 설정
### 먼저 다음 명령어들을 실행하여 실습 환경을 구성하세요:

```
# 실습 디렉터리 생성(/root 사용)
mkdir permission_practice
cd permission_practice


# 사용자 및 그룹 생성 (관리자 권한 필요)
sudo useradd -m -s /bin/bash alice
sudo useradd -m -s /bin/bash bob
sudo useradd -m -s /bin/bash charlie
sudo useradd -m -s /bin/bash diana
sudo useradd -m -s /bin/bash eve


# 그룹 생성
sudo groupadd developers
sudo groupadd managers


# 사용자를 그룹에 추가
sudo usermod -a -G developers alice
sudo usermod -a -G developers bob
sudo usermod -a -G developers charlie
sudo usermod -a -G managers diana
sudo usermod -a -G managers alice
# eve는 기타 사용자로 어떤 그룹에도 속하지 않음


# 복잡한 디렉터리 구조 생성
mkdir -p {company/{departments/{dev,hr,finance,marketing},projects/{project_a,project_b,project_c}},shared/{documents,resources,tools},private/{alice,bob,charlie,diana,eve},backup/{daily,weekly,monthly},logs/{2023/{01..12},2024/{01..12}}}


# 다양한 파일 생성
touch company/departments/dev/{main.py,test.py,config.py,README.md}
touch company/departments/hr/{employees.xlsx,contracts.pdf,policies.txt}
touch company/departments/finance/{budget.xlsx,reports.pdf,invoices.csv}
touch company/projects/project_a/{spec.doc,code.zip,data.json}
touch company/projects/project_b/{requirements.txt,source.tar.gz,notes.md}
touch shared/documents/{manual.pdf,guidelines.txt,templates.docx}
touch shared/resources/{images.zip,fonts.tar,icons.png}
touch private/alice/{personal.txt,settings.conf,backup.tar}
touch private/bob/{notes.md,config.json,archive.zip}
touch backup/daily/{backup_$(date +%Y%m%d).tar.gz,log_$(date +%Y%m%d).txt}
touch logs/2024/06/{access.log,error.log,debug.log,system.log}


# 실행 가능한 스크립트 파일 생성
echo '#!/bin/bash' > shared/tools/deploy.sh
echo 'echo "Deployment script"' >> shared/tools/deploy.sh
echo '#!/bin/bash' > shared/tools/backup.sh
echo 'echo "Backup script"' >> shared/tools/backup.sh
echo '#!/bin/bash' > company/departments/dev/build.sh
echo 'echo "Build script"' >> company/departments/dev/build.sh


# 설정 파일 생성
echo "database_host=localhost" > company/departments/dev/database.conf
echo "api_key=secret123" > company/departments/dev/api.conf
echo "salary_data=confidential" > company/departments/hr/salaries.txt


echo "실습 환경이 구성되었습니다!"
tree permission_practice
```

# 1. 기본 권한 설정
## 1-1. 개발팀 파일 권한 설정
### 개발팀(developers 그룹) 관련 파일들의 권한을 다음과 같이 설정하세요:
### company/departments/dev/ 디렉터리: 개발팀만 접근 가능, 소유자와 그룹은 읽기/쓰기/실행 가능
```shell
명령어를 작성하세요: 
[root@localhost permission_practice]# chown -R :developers company/departments/dev/
[root@localhost permission_practice]# chmod -R 770 company/departments/dev/ 
[root@localhost permission_practice]# ls -la company/departments/dev/
total 12
drwxrwx---. 2 alice developers 123 Jul 21 16:49 .
drwxr-xr-x. 6 root  developers  59 Jul 21 16:49 ..
-rwxrwx---. 1 alice developers  18 Jul 21 16:49 api.conf
-rwxrwx---. 1 alice developers  32 Jul 21 16:49 build.sh
-rwxrwx---. 1 alice developers   0 Jul 21 16:49 config.py
-rwxrwx---. 1 alice developers  24 Jul 21 16:49 database.conf
-rwxrwx---. 1 alice developers   0 Jul 21 16:49 main.py
-rwxrwx---. 1 alice developers   0 Jul 21 16:49 README.md
-rwxrwx---. 1 alice developers   0 Jul 21 16:49 test.py
```
### company/departments/dev/main.py: 개발팀은 읽기/쓰기, 기타는 읽기만 가능
```shell
[root@localhost permission_practice]# chmod 664 company/departments/dev/main.py [root@localhost permission_practice]# ls -la company/departments/dev/main.py 
-rw-rw-r--. 1 alice developers 0 Jul 21 16:49 company/departments/dev/main.py
```

### company/departments/dev/build.sh: 개발팀만 실행 가능
```
[root@localhost permission_practice]# chmod 110 company/departments/dev/build.sh 
[root@localhost permission_practice]# ls -la company/departments/dev/build.sh 
---x--x---. 1 alice developers 32 Jul 21 16:49 company/departments/dev/build.sh
[root@localhost permission_practice]# 

```

# 1-2. 개인 디렉터리 보안 설정
## 각 사용자의 개인 디렉터리와 파일을 다음과 같이 설정하세요:
### private/alice/ 디렉터리: alice만 접근 가능
```
명령어를 작성하세요:
[root@localhost permission_practice]# chown -R alice:alice private/alice/ 
[root@localhost permission_practice]# chmod 770 private/alice/
[root@localhost permission_practice]# ls -la private/alice/
total 0
drwxrwx---. 2 alice alice 65 Jul 21 16:49 .
drwxr-xr-x. 7 root  root  69 Jul 21 16:49 ..
-rwx------. 1 alice alice  0 Jul 21 16:49 backup.tar
-rwx------. 1 alice alice  0 Jul 21 16:49 personal.txt
-rwx------. 1 alice alice  0 Jul 21 16:49 settings.conf
```
### private/alice/personal.txt: alice만 읽기/쓰기 가능
```
[root@localhost permission_practice]# sudo chown alice:alice private/alice/personal.txt
[root@localhost permission_practice]# sudo chmod -R 600 private/alice/personal.txt
[root@localhost permission_practice]# ls -la private/alice/personal.txt 
-rw-------. 1 alice alice 0 Jul 21 16:49 private/alice/personal.txt
```

### private/bob/config.json: bob만 읽기/쓰기 가능
```
[root@localhost permission_practice]# chown bob:bob private/bob/config.json 
[root@localhost permission_practice]# chmod 600 private/bob/config.json 
[root@localhost permission_practice]# ls -la private/bob/config.json 
-rw-------. 1 bob bob 0 Jul 21 16:49 private/bob/config.json
```
# 2. 그룹 기반 권한 관리
## 2-1. 공유 리소스 접근 권한
### shared/ 디렉터리의 권한을 다음과 같이 설정하세요:
### shared/documents/: developers와 managers 그룹 모두 읽기 가능, 소유자만 쓰기 가능
```
root@localhost permission_practice]# groupadd All 
[root@localhost permission_practice]# usermod -aG All alice
[root@localhost permission_practice]# usermod -aG All diana
[root@localhost permission_practice]# usermod -aG All bob
[root@localhost permission_practice]# usermod -aG All charlie
[root@localhost permission_practice]# usermod -aG All diana

[root@localhost permission_practice]# sudo chown -R  root:All shared/documents/
[root@localhost permission_practice]# sudo chmod -R 240 shared/documents/
[root@localhost permission_practice]# ls -la shared/documents/
total 0
drwxr-xr-x. 2 root All  68 Jul 21 16:49 .
drwxr-xr-x. 5 root root 53 Jul 21 16:49 ..
--w-r-----. 1 root All   0 Jul 21 16:49 guidelines.txt
--w-r-----. 1 root All   0 Jul 21 16:49 manual.pdf
--w-r-----. 1 root All   0 Jul 21 16:49 templates.docx
All:x:1012:alice,diana,bob,charlie
```
### shared/resources/: developers 그룹만 접근 가능
```
[root@localhost permission_practice]# chown -R :developers shared/resources/
[root@localhost permission_practice]# chmod 770 shared/resources/
[root@localhost permission_practice]# ls -la shared/resources/
```
### shared/tools/: 모든 사용자가 읽기 가능, developers 그룹만 실행 가능
```
[root@localhost permission_practice]# chown -R :developers shared/tools/
[root@localhost permission_practice]# chmod -R 474 shared/tools/
[root@localhost permission_practice]# ls -la shared/tools/
```


# 2-2. 프로젝트별 협업 권한
## 프로젝트 디렉터리의 권한을 다음과 같이 설정하세요:
### company/projects/project_a/: developers 그룹 구성원들이 협업할 수 있도록 설정
```
[root@localhost permission_practice]# chown :developers company/projects/project_a 

[root@localhost permission_practice]# chmod -R 770 company/projects/project_a
[root@localhost permission_practice]# ls -la company/projects/project_a
total 0
drwxrwx---. 2 root developers 55 Jul 21 16:49 .
drwxr-xr-x. 5 root developers 57 Jul 21 16:49 ..
-rwxrwx---. 1 root developers  0 Jul 21 16:49 code.zip
-rwxrwx---. 1 root developers  0 Jul 21 16:49 data.json
-rwxrwx---. 1 root developers  0 Jul 21 16:49 spec.doc
```
### company/projects/project_b/: alice와 bob만 접근 가능하도록 설정
- 명령어를 작성하세요:
```
root@localhost permission_practice]# sudo groupadd pro_b
[root@localhost permission_practice]# sudo usermod -aG pro_b alice
[root@localhost permission_practice]# sudo usermod -aG pro_b bob
[root@localhost permission_practice]# sudo chown -R root:pro_b company/projects/project_b
[root@localhost permission_practice]# sudo chmod -R 770 company/projects/project_b
pro_b:x:1010:alice,bob
[root@localhost permission_practice]# ls -la company/projects/project_b
total 0
drwxrwx---. 2 root pro_b      67 Jul 21 16:49 .
drwxr-xr-x. 5 root developers 57 Jul 21 16:49 ..
-rwxrwx---. 1 root pro_b       0 Jul 21 16:49 notes.md
-rwxrwx---. 1 root pro_b       0 Jul 21 16:49 requirements.txt
-rwxrwx---. 1 root pro_b       0 Jul 21 16:49 source.tar.gz

cat /etc/group
pro_b:x:1010:alice,bob
```


# 3. 고급 권한 설정
### 3-1. 특수 권한 적용

### shared/tools/deploy.sh: SetGID 설정으로 developers 그룹 권한으로 실행
```
[root@localhost permission_practice]# chown :developers shared/tools/deploy.sh 
[root@localhost permission_practice]# chmod g+s shared/tools/deploy.sh 
[root@localhost permission_practice]# chmod 2755 shared/tools/deploy.sh 
[root@localhost permission_practice]# ls -la shared/tools/deploy.sh 
-rwxr-sr-x. 1 root developers 37 Jul 21 16:49 shared/tools/deploy.sh

```
### company/departments/hr/salaries.txt: SetUID 설정 (실제 환경에서는 권장하지 않지만 실습용)
- 명령어를 작성하세요:
```
[root@localhost permission_practice]# chmod u+s company/departments/hr/salaries.txt 
[root@localhost permission_practice]# chmod 4755 company/departments/hr/salaries.txt 
[root@localhost permission_practice]# ls -la company/departments/hr/salaries.txt 
-rwsr-xr-x. 1 root developers 25 Jul 21 16:49 company/departments/hr/salaries.txt
[root@localhost permission_practice]# 
```



# 3-2. 숫자 표기법으로 복합 권한 설정
## 다음 파일들의 권한을 숫자 표기법으로 설정하세요:
- 명령어를 작성하세요:

### company/departments/finance/budget.xlsx: 소유자(rw-), 그룹(r--), 기타(---)
```
[root@localhost permission_practice]# chmod 640 company/departments/finance/budget.xlsx 
```
### shared/documents/manual.pdf: 소유자(rw-), 그룹(r--), 기타(r--)
```
[root@localhost permission_practice]# sudo chmod 644 shared/documents/manual.pdf
```
### logs/2024/06/system.log: 소유자(rw-), 그룹(r--), 기타(---)
```
[root@localhost permission_practice]# sudo chmod 640 logs/2024/06/system.log 
```

# 4. 소유권 및 그룹 관리
## 4-1. 소유권 변경
### 다음과 같이 파일과 디렉터리의 소유권을 변경하세요:
#### company/departments/dev/ 디렉터리와 모든 하위 파일: alice 소유, developers 그룹
```
[root@localhost permission_practice]# chown -R alice:developers company/departments/dev/
[root@localhost permission_practice]# ls -la company/departments/dev/
total 12
drwxrwx---. 2 alice developers 123 Jul 21 16:49 .
drwxr-xr-x. 6 root  developers  59 Jul 21 16:49 ..
-rw-r--r--. 1 alice developers  18 Jul 21 16:49 api.conf
---x--x---. 1 alice developers  32 Jul 21 16:49 build.sh
-rw-r--r--. 1 alice developers   0 Jul 21 16:49 config.py
-rw-r--r--. 1 alice developers  24 Jul 21 16:49 database.conf
-rw-r--r--. 1 alice developers   0 Jul 21 16:49 main.py
-rw-r--r--. 1 alice developers   0 Jul 21 16:49 README.md
-rw-r--r--. 1 alice developers   0 Jul 21 16:49 test.py
```
### company/departments/hr/ 디렉터리와 모든 하위 파일: diana 소유, managers 그룹
```
[root@localhost permission_practice]# chown -R diana:managers company/departments/hr
[root@localhost permission_practice]# ls -la company/departments/hr/ 
total 4
drwxr-xr-x. 2 diana managers   89 Jul 21 16:49 .
drwxr-xr-x. 6 root  developers 59 Jul 21 16:49 ..
-rw-r--r--. 1 diana managers    0 Jul 21 16:49 contracts.pdf
-rw-r--r--. 1 diana managers    0 Jul 21 16:49 employees.xlsx
-rw-r--r--. 1 diana managers    0 Jul 21 16:49 policies.txt
-rwxr-xr-x. 1 diana managers   25 Jul 21 16:49 salaries.txt
[root@localhost permission_practice]# 
```
### shared/tools/ 디렉터리와 모든 하위 파일: root 소유, developers 그룹
- 명령어를 작성하세요:
```
[root@localhost permission_practice]# chown -R root:developers shared/tools/
[root@localhost permission_practice]# ls -la shared/tools/
total 8
dr--r-xr--. 2 root developers 40 Jul 21 16:49 .
drwxr-xr-x. 5 root root       53 Jul 21 16:49 ..
-r--r-xr--. 1 root developers 33 Jul 21 16:49 backup.sh
-rwxr-xr-x. 1 root developers 37 Jul 21 16:49 deploy.sh
[root@localhost permission_practice]# 
```

# 4-2. 그룹 전용 변경
## 다음 디렉터리들의 그룹만 변경하세요:
### company/projects/: managers 그룹으로 변경
```
[root@localhost permission_practice]# chown -R :managers company/projects/
[root@localhost permission_practice]# ls -la company/projects/
total 0
drwxr-xr-x. 5 root managers   57 Jul 21 16:49 .
drwxr-xr-x. 4 root developers 41 Jul 21 16:49 ..
drwxrwx---. 2 root managers   55 Jul 21 16:49 project_a
drwxrwx---. 2 root managers   67 Jul 21 16:49 project_b
drwxr-xr-x. 2 root managers    6 Jul 21 16:49 project_c
[root@localhost permission_practice]# 
```

### backup/daily/: developers 그룹으로 변경
```
[root@localhost permission_practice]# chown -R :developers backup/daily/
[root@localhost permission_practice]# ls -la backup/daily/
total 0
drwxr-xr-x. 2 root developers 60 Jul 21 16:49 .
drwxr-xr-x. 5 root root       48 Jul 21 16:49 ..
-rw-r--r--. 1 root developers  0 Jul 21 16:49 backup_20250721.tar.gz
-rw-r--r--. 1 root developers  0 Jul 21 16:49 log_20250721.txt
[root@localhost permission_practice]# 
```

# 8. 실행 권한 및 스크립트 관리
## 8-1. 스크립트 실행 환경 설정
## 다음 스크립트 파일들의 실행 권한을 적절히 설정하세요:
### shared/tools/deploy.sh: developers 그룹만 실행 가능
```
[root@localhost permission_practice]# chown :developers shared/tools/deploy.sh 
[root@localhost permission_practice]# ls -la shared/tools/deploy.sh 
-rwxr-xr-x. 1 root developers 37 Jul 21 16:49 shared/tools/deploy.sh
```
### shared/tools/backup.sh: alice와 diana만 실행 가능
```
[root@localhost permission_practice]# sudo groupadd back_a
[root@localhost permission_practice]# sudo usermod -aG back_a alice
[root@localhost permission_practice]# sudo usermod -aG back_a diana 
[root@localhost permission_practice]# sudo chown :back_a shared/tools/backup.sh 
[root@localhost permission_practice]# sudo chmod 770 shared/tools/backup.sh 
[root@localhost permission_practice]# ls -la shared/tools/backup.sh 
-rwxrwx---. 1 root back_a 33 Jul 21 16:49 shared/tools/backup.sh
[root@localhost permission_practice]# cat /etc/grou
back_a:x:1011:alice,diana
```

### company/departments/dev/build.sh: 소유자만 실행 가능
```
[root@localhost permission_practice]# chmod 700 company/departments/dev/build.sh 
[root@localhost permission_practice]# ls -la company/departments/dev/build.sh 
-rwx------. 1 alice developers 32 Jul 21 16:49 company/departments/dev/build.sh
[root@localhost permission_practice]#
```

# 8-2. 시스템 스크립트 보안 설정
## 시스템 관리용 스크립트를 다음과 같이 설정하세요:
### root 소유의 시스템 관리 스크립트 생성 (system_check.sh)
### 일반 사용자가 sudo 없이 실행할 수 있도록 SetUID 설정
### 실행 로그를 남기도록 권한 설정
# 8-2 답안 작성란






# 9. 디렉터리별 접근 제어
## 9-1. 계층적 접근 제어
### 다음과 같은 계층적 접근 권한을 설정하세요:

### company/ : 모든 직원이 읽기 가능
```
[root@localhost permission_practice]# chown -R root:All company/
[root@localhost permission_practice]# chmod 440 company/
[root@localhost permission_practice]# ls -la company/
total 0
dr--r-----. 4 root All  41 Jul 21 16:49 .
drwxr-xr-x. 7 root root 76 Jul 21 16:49 ..
dr--r--r--. 6 root All  59 Jul 21 16:49 departments
dr--r--r--. 5 root All  57 Jul 21 16:49 projects

```
### company/departments/ : 각 부서원만 해당 부서 디렉터리 접근 가능
```
[root@localhost permission_practice]# chown -R  :developers company/departments/
[root@localhost permission_practice]# chmod 770 -R company/departments/
[root@localhost permission_practice]# ls -la company/departments/
total 0
drwxrwx---. 6 root developers  59 Jul 21 16:49 .
dr--r-----. 4 root All         41 Jul 21 16:49 ..
drwxrwx---. 2 root developers 123 Jul 21 16:49 dev
drwxrwx---. 2 root developers  64 Jul 21 16:49 finance
drwxrwx---. 2 root developers  89 Jul 21 16:49 hr
drwxrwx---. 2 root developers   6 Jul 21 16:49 marketing

```
### company/departments/finance/ : managers 그룹만 접근 가능
```
[root@localhost permission_practice]# sudo chown -R  :managers company/departments/finance/
[root@localhost permission_practice]# sudo chmod -R  070 company/departments/finance/
[root@localhost permission_practice]# ls -la company/departments/finance/
total 0
d---rwx---. 2 root managers 64 Jul 21 16:49 .
dr--r--r--. 6 root All      59 Jul 21 16:49 ..
----rwx---. 1 root managers  0 Jul 21 16:49 budget.xlsx
----rwx---. 1 root managers  0 Jul 21 16:49 invoices.csv
----rwx---. 1 root managers  0 Jul 21 16:49 reports.pdf
[root@localhost permission_practice]# 
```
### company/projects/ : 프로젝트 참여자만 해당 프로젝트 접근 가능
```
[root@localhost permission_practice]# chmod -R 770 company/projects/
[root@localhost permission_practice]# ls -la company/projects/
total 0
drwxrwx---. 5 root managers 57 Jul 21 16:49 .
dr--r-----. 4 root All      41 Jul 21 16:49 ..
drwxrwx---. 2 root managers 55 Jul 21 16:49 project_a
drwxrwx---. 2 root managers 67 Jul 21 16:49 project_b
drwxrwx---. 2 root managers  6 Jul 21 16:49 project_c
[root@localhost permission_practice]# 
```

# 9-2. 임시 작업 공간 설정
## 임시 작업을 위한 공간을 다음과 같이 설정하세요:
### temp/ 디렉터리 생성 (모든 사용자가 파일 생성 가능)

```
[root@localhost permission_practice]# mkdir temp/
[root@localhost permission_practice]# ls -la
total 4
drwxr-xr-x. 8 root root   88 Jul 21 18:54 .
dr-xr-x---. 5 root root 4096 Jul 21 17:15 ..
drwxr-xr-x. 5 root root   48 Jul 21 16:49 backup
dr--r-----. 4 root All    41 Jul 21 16:49 company
drwxr-xr-x. 4 root root   30 Jul 21 16:49 logs
drwxr-xr-x. 7 root root   69 Jul 21 16:49 private
drwxr-xr-x. 5 root root   53 Jul 21 16:49 shared
drwxr-xr-x. 2 root root    6 Jul 21 18:54 temp
[root@localhost permission_practice]# 
```

```
### Sticky Bit 설정으로 자신의 파일만 삭제 가능
### 1주일 후 자동 삭제되도록 권한 설정 (cron 작업용)
```

# 10. 백업 및 아카이브 권한 관리
## 10-1. 백업 파일 보안
### 백업 관련 파일들의 보안을 다음과 같이 설정하세요:
### backup/daily/ : developers 그룹이 백업 생성 가능, 읽기 전용
```
[root@localhost permission_practice]# chown -R  bob:developers backup/daily/
[root@localhost permission_practice]# chmod -R 474 backup/daily/
[root@localhost permission_practice]# ls -la backup/daily/
total 0
dr--rwxr--. 2 bob  developers 60 Jul 21 16:49 .
drwxr-xr-x. 5 root root       48 Jul 21 16:49 ..
-r--rwxr--. 1 bob  developers  0 Jul 21 16:49 backup_20250721.tar.gz
-r--rwxr--. 1 bob  developers  0 Jul 21 16:49 log_20250721.txt
[root@localhost permission_practice]# 
```
### backup/weekly/ : managers만 접근 가능
```
[root@localhost permission_practice]# chown -R  diana:managers backup/weekly/
[root@localhost permission_practice]# chmod -R  770 backup/weekly/
[root@localhost permission_practice]# ls -la backup/weekly/
total 0
drwxrwx---. 2 diana managers  6 Jul 21 16:49 .
drwxr-xr-x. 5 root  root     48 Jul 21 16:49 ..
[root@localhost permission_practice]# 
```
### backup/monthly/ : root만 접근 가능
```
[root@localhost permission_practice]# chown -R root:root backup/monthly/
[root@localhost permission_practice]# chmod -R 770 backup/monthly/
[root@localhost permission_practice]# ls -la backup/monthly/
total 0
drwxrwx---. 2 root root  6 Jul 21 16:49 .
drwxr-xr-x. 5 root root 48 Jul 21 16:49 ..
[root@localhost permission_practice]# 

```

### 모든 백업 파일은 생성 후 읽기 전용으로 자동 변경




