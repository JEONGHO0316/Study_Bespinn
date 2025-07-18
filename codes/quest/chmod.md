
# Linux 실습 문제지 - nano, 쉘 스크립트, 다중 명령어, chmod
## 기본 개념 정리
## nano 편집기
## nano : 터미널 기반 텍스트 편집기
## Ctrl+X : 편집기 종료
## Ctrl+O : 파일 저장
## Ctrl+K : 현재 줄 잘라내기
## Ctrl+U : 잘라낸 텍스트 붙여넣기

# 쉘 스크립트 기본
## !/bin/bash : 쉘 스크립트 시작 라인 (shebang)
- 실행 권한 : chmod +x 파일명
- 실행 방법 : ./파일명 또는 bash 파일명
- 다중 명령어 연산자
- && : 앞 명령어가 성공하면 뒤 명령어 실행
- || : 앞 명령어가 실패하면 뒤 명령어 실행
- ; : 앞 명령어 결과와 관계없이 순차 실행
- chmod 권한 설정
- r(읽기) : 4, w(쓰기) : 2, x(실행) : 1
- 755 : 소유자(rwx), 그룹(rx), 기타(rx)
- 644 : 소유자(rw), 그룹(r), 기타(r)


# 문제 1: nano 편집기 사용
## 1-1. 기본 파일 생성 및 편집

hello.sh 파일을 nano로 열어 다음 내용을 작성하세요:
!/bin/bash
echo "안녕하세요! 리눅스 세계에 오신 것을 환영합니다."

명령어를 작성하세요:
\# nano 편집기로 hello.sh 파일 열기
``` 
nano hello.sh 
#!/bin/bash

echo "안녕하세요! 리눅스 세계에 오신 것을 환영합니다."
cat hello.sh
​
```


# 1-2. 파일 내용 수정
## system_info.txt 파일을 nano로 열어 현재 시스템 정보를 기록하는 내용을 작성하세요.
```
명령어를 작성하세요:
\# nano 편집기로 system_info.txt 파일 열기
```

# 문제 2: 쉘 스크립트 작성 및 실행
## 2-1. 기본 쉘 스크립트 작성
```
backup.sh 파일을 만들어 다음 기능을 수행하는 스크립트를 작성하세요:
현재 날짜 출력
"백업을 시작합니다" 메시지 출력
현재 디렉터리의 파일 목록 출력
명령어를 작성하세요:
\# nano로 backup.sh 파일 생성 및 편집
$ nano backup.sh 
date
"백업을 시작합니다"
ls -l ./
```

​
# 2-2. 스크립트 실행 권한 부여
```
backup.sh 파일에 실행 권한을 부여하세요.
명령어를 작성하세요:
\# backup.sh 파일에 실행 권한 부여
# chmod 700 backup.sh
```


# 2-3. 스크립트 실행
```
작성한 backup.sh 스크립트를 실행하세요.
명령어를 작성하세요:
\# backup.sh 스크립트 실행
# ./backup.sh
``` 

# 문제 3: && 연산자를 이용한 다중 명령어

## 3-1. 조건부 실행
```
디렉터리 생성이 성공하면 해당 디렉터리로 이동하는 명령어를 작성하세요.
명령어를 작성하세요:
\# new_project 디렉터리 생성 후 성공하면 이동
# mkdir new_project && cd new_project
```

## 3-2. 파일 생성 및 편집
```
test.txt 파일을 생성하고 성공하면 nano로 편집하는 명령어를 작성하세요.
명령어를 작성하세요:
\# test.txt 파일 생성 후 성공하면 nano로 편집
# touch test.txt && nano test.txt
```


# 3-3. 복합 조건부 실행
```
스크립트 파일을 생성하고, 실행 권한을 부여한 후, 실행하는 일련의 명령어를 작성하세요.
명령어를 작성하세요:
\# quick_test.sh 파일에 "echo 'Hello World'" 내용 저장 후 실행 권한 부여 후 실행

nano quick_test.sh && echo “'Hello World'" && chmod 700 quick_test.sh && ./quick_test.sh
``` 

# 문제 4: chmod를 이용한 권한 조정
 ## 4-1. 기본 권한 설정
```
test_script.sh 파일을 생성하고 소유자에게만 모든 권한을 부여하세요.
명령어를 작성하세요:
\# test_script.sh 파일 생성
\# 소유자에게만 읽기, 쓰기, 실행 권한 부여 (700)
 # touch test_script.sh &&chmod 700 test_script.sh
``` 
# 4-2. 그룹 권한 추가

## test_script.sh 파일에 그룹 사용자에게 읽기 및 실행 권한을 추가하세요.

```
명령어를 작성하세요:
\# 그룹에 읽기, 실행 권한 추가 (750)
 # chmod 750 test_script.sh
 ```
 
# 4-3. 권한 확인
```
파일의 현재 권한을 확인하는 명령어를 작성하세요.
명령어를 작성하세요:
\# 파일 권한 확인
ls -la ./
```

# 4-4. 실행 권한 제거
```
test_script.sh 파일에서 모든 사용자의 실행 권한을 제거하세요.
명령어를 작성하세요:
\# 모든 사용자의 실행 권한 제거
# chmod 600 test_script.sh
``` 

# 문제 5: 종합 실습

## 5-1. 자동화 스크립트 작성
```
다음 기능을 수행하는 setup.sh 스크립트를 작성하세요:
logs 디렉터리가 없으면 생성
현재 날짜와 시간을 logs/setup.log 파일에 기록
"설정 완료" 메시지 출력
작성할 스크립트 내용:
|| mkdir logs && cd ./logs && nano setup.log  && “설정완료”
!/bin/bash
\# setup.sh 스크립트 내용을 작성하세요
``` 

# 5-2. 스크립트 실행 및 검증
```
setup.sh 스크립트를 실행하고, 로그 파일이 제대로 생성되었는지 확인하는 명령어를 작성하세요.
#  ls -l ./logs/setup.log 
명령어를 작성하세요:
\# setup.sh 실행 권한 부여 후 실행하고, 로그 파일 내용 확인
# chmod 700 setup.sh ./setup.sh
```

# 🔧 문제 7: 디렉토리 및 권한 실습
## 7-1. 디렉토리 생성 및 권한 변경
```
project_logs 디렉토리를 생성하고, 사용자(User)에게만 쓰기 권한을 제거한 후 권한을 확인하는 명령어를 작성하세요.
명령어를 작성하세요:
\# project_logs 디렉토리 생성 후 User의 쓰기 권한 제거, 권한 확인
# mkdir project_logs && chmod 500 && ls -la project_logs 
``` 

# 7-2. nano를 사용한 쉘 스크립트 작성

## nano 편집기로 check_dir.sh 스크립트를 작성하세요. 이 스크립트는 다음을 수행합니다:
- backup 디렉토리가 존재하는지 확인
- 존재하면 backup 내부에 checked.txt 파일 생성
- 존재하지 않으면 "backup 디렉토리가 없습니다" 메시지 출력
```
nano에서 작성할 내용 예시:
ls -la ./backup/ && cd ./backup && touch checked.txt ||  "backup 디렉토리가 없습니다.”
```

!/bin/bash
\# backup 디렉토리 존재 확인
\# 존재하면 checked.txt 생성, 없으면 메시지 출력
# 7-3. 다중 명령어 조건 실행
- project_logs 디렉토리로 이동한 후, 이동에 성공한 경우 log.txt 파일을 만들고 ## - "로그 생성 완료" 메시지를 출력하는 명령어를 작성하세요.
```
명령어를 작성하세요:
\# 디렉토리 이동 && 파일 생성 && 메시지 출력

cd ./ project_logs && nano log.txt && "로그 생성 완료" 
``` 

# 7-4. 쉘 스크립트 실행 권한 설정 (User만)

- 앞서 작성한 check_dir.sh 파일에 대해 사용자(User) 에게만 실행 권한을 부여하고 - - 현재 권한을 확인하는 명령어를 작성하세요.
- 명령어를 작성하세요:
\# 사용자에게만 실행 권한 부여 및 권한 확인

```
[jeongho@localhost shell_practice]$ chmod 100 check_dir.sh && ls -la check_dir.sh
---x------. 1 jeongho jeongho 96 Jul 18 17:59 check_dir.sh
```

주의사항:
- 모든 명령어는 실제 터미널에서 테스트해보세요
- 스크립트 작성 시 shebang(#!/bin/bash)을 반드시 포함하세요
- 권한 변경 후에는 ls -l 명령어로 확인하는 습관을 가지세요
- 실습 후 생성된 파일들은 정리해주세요