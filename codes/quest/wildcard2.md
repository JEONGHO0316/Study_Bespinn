Linux 파일 관리 명령어 와일드카드 실습 문제
실습 환경 설정
먼저 다음 명령어들을 실행하여 실습 환경을 구성하세요:

# 실습 디렉터리 생성
```

mkdir wildcard_file_practice

cd wildcard_file_practice
```

# 테스트 파일들 생성
```
touch report1.txt report2.txt report3.txt

touch data1.csv data2.csv data3.csv data_old.csv

touch image1.jpg image2.jpg image3.png photo.gif

touch backup_2023.tar backup_2024.tar config.conf

touch log_error.txt log_access.txt log_system.txt

touch temp1.tmp temp2.tmp temp3.tmp

touch file_001.dat file_002.dat file_010.dat

touch script1.sh script2.sh test_script.sh

touch document.pdf presentation.ppt spreadsheet.xls

touch readme.md changelog.md license.txt

touch old_report.txt new_report.txt final_report.txt
```

# 기본 디렉터리들 생성
```
mkdir archives backup logs images documents scripts
```

1. mkdir 명령어 와일드카드 실습
1-1. 연도별 백업 디렉터리 생성

# 2020년부터 2024년까지 백업 디렉터리를 한 번에 생성하세요
```
예: backup_2020, backup_2021, backup_2022, backup_2023, backup_2024
# 명령어를 작성하세요:
mkdir backup_{2020..2024}
```

# 1-2. 월별 로그 디렉터리 생성
logs 디렉터리 안에 01월부터 12월까지 디렉터리 생성
```
# 예: logs/log_01, logs/log_02, ..., logs/log_12

# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cd ./logs/
[jeongho@localhost logs]$ mkdir logs_{01..12}
[jeongho@localhost logs]$ ls
```
1-3. 프로젝트별 디렉터리 생성

# project_A, project_B, project_C 디렉터리를 한 번에 생성하세요
```
# 명령어를 작성하세요:
[jeongho@localhost logs]$ mkdir project_{A..C}
```


# 1-4. 계층적 디렉터리 생성
data/2024/{01,02,03} 구조로 디렉터리를 생성하세요
- (data 디렉터리 안에 2024 디렉터리, 그 안에 01, 02, 03 디렉터리)
```
# 명령어를 작성하세요:
[jeongho@localhost logs]$ mkdir -p ./data/2024/{01..03}
```




# 2. cp 명령어 와일드카드 실습
# 2-1. 확장자별 파일 복사
 - 모든 .txt 파일을 backup 디렉터리로 복사하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cp *.txt ./backup

```

2-2. 특정 패턴 파일 복사
# "report"로 시작하는 모든 파일을 documents 디렉터리로 복사하세요
```
# 명령어를 작성하세요
[jeongho@localhost wildcard_file_practice]$ cp report*.* ./documents
```

# 2-3. 숫자가 포함된 파일 복사
- 파일명에 숫자가 포함된 모든 이미지 파일(.jpg, .png)을 images 디렉터리로 복사하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cp *[0-9]*.{jpg,png} ./images/
```


# 2-4. 특정 범위의 파일 복사
- data1.csv, data2.csv, data3.csv 파일만 backup 디렉터리로 복사하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cp data{1..3}.csv ./backup

```


# 2-5. 복합 조건 파일 복사
-  "log_"로 시작하는 .txt 파일들을 logs 디렉터리로 복사하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cp [logs_]*.txt ./logs
```
# 3. mv 명령어 와일드카드 실습
- 3-1. 임시 파일 이동

# 명령어를 작성하세요:
# 모든 .tmp 파일을 temp 디렉터리로 이동하세요 (mkdir temp 먼저 실행)
```
[jeongho@localhost wildcard_file_practice]$ mkdir temp
[jeongho@localhost wildcard_file_practice]$ mv *.tmp ./temp
```
# 3-2. 백업 파일 정리
- "backup_"로 시작하는 모든 파일을 archives 디렉터리로 이동하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ mv backup_* archives/
```
# 3-3. 스크립트 파일 정리
# 모든 .sh 파일을 scripts 디렉터리로 이동하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ mv *.sh ./scripts
```
3-4. 특정 패턴 파일 이동
# "file_"로 시작하고 3자리 숫자가 포함된 .dat 파일들을 data 디렉터리로 이동하세요
# (data 디렉터리가 없다면 먼저 생성)
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ mkdir data
[jeongho@localhost wildcard_file_practice]$ mv file_*???.dat ./data
```
3-5. 조건부 파일 이동
# "old_" 또는 "new_"로 시작하는 모든 파일을 archives 디렉터리로 이동하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ mv {old_,new_}*.* ./archives/

```
# 4. rm 명령어 와일드카드 실습
- 4-1. 임시 파일 삭제
- 모든 .tmp 파일을 삭제하세요 (주의: 실제로는 신중히 실행)
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cd ./temp/
[jeongho@localhost temp]$ rm  *.tmp
```

# 4-2. 특정 패턴 파일 삭제
- "temp"로 시작하는 모든 파일을 삭제하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ rm temp*
```
# 4-3. 백업 파일 정리
- 2023년 백업 파일만 삭제하세요 (backup_2023.tar)
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cd ./archives/
[jeongho@localhost archives]$ rm -r backup_2024.tar/
```


# 4-4. 조건부 파일 삭제
- 확장자가 3글자가 아닌 파일들을 삭제하세요

- 힌트: 확장자가 .jpg, .png, .gif, .txt, .csv, .tar, .dat, .pdf, .ppt, .xls가 아닌 파일
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ ls -l *.[a-z][a-z]

```

# 5. 복합 명령어 실습
- 5-1. 파일 정리 시스템
- 1단계: 모든 이미지 파일(.jpg, .png, .gif)을 images 디렉터리로 이동
```
[jeongho@localhost wildcard_file_practice]$ mv  *.{jpg,png,gif} ./images

```

# 2단계: 모든 문서 파일(.pdf, .ppt, .xls, .md)을 documents 디렉터리로 이동
```
[jeongho@localhost wildcard_file_practice]$ mv *.{pdf,ppt,xls,md} ./documents 
```

# 3단계: 모든 데이터 파일(.csv, .dat)을 data 디렉터리로 이동 (없으면 생성)
```
# 명령어들을 작성하세요:
[jeongho@localhost wildcard_file_practice]$ mv *.{csv,dat} ./data
```


5-2. 백업 및 정리 작업
# 1단계: 모든 .txt 파일을 backup/txt_files 디렉터리로 복사 (디렉터리 생성 필요)
```
[jeongho@localhost backup]$ mkdir txt_files
[jeongho@localhost backup]$ ls
config     data3.csv         log_access.txt  new_report.txt  report2.txt
data1.csv  final_report.txt  log_error.txt   old_report.txt  report3.txt
data2.csv  license.txt       log_system.txt  report1.txt     txt_files
[jeongho@localhost backup]$ cd ..

[jeongho@localhost wildcard_file_practice]$ cp *.txt ./backup/txt_files/
[jeongho@localhost wildcard_file_practice]$ ls -l ./backup/txt_files/
total 0
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 final_report.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 license.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 log_access.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 log_error.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 log_system.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 report1.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 report2.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:08 report3.txt

```

# 2단계: 모든 설정 파일(.conf)을 backup/config 디렉터리로 복사
```
[jeongho@localhost wildcard_file_practice]$ cd ./backup
[jeongho@localhost backup]$ mkdir config
[jeongho@localhost backup]$ ls

[jeongho@localhost wildcard_file_practice]$ ls -l *.conf
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 17:41 config.conf
[jeongho@localhost wildcard_file_practice]$ cp *.conf ./backup/config/
[jeongho@localhost wildcard_file_practice]$ ls -l ./backup/config/
total 0
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:10 config.conf


```

# 3단계: 원본 설정 파일들을 삭제
```
# 명령어들을 작성하세요:
[jeongho@localhost wildcard_file_practice]$ rm config.conf
```


# 5-3. 날짜별 로그 정리
# 1단계: logs 디렉터리에 error, access, system 하위 디렉터리 생성
```
[jeongho@localhost wildcard_file_practice]$ cd ./logs/
[jeongho@localhost logs]$ mkdir error access system

```

# 2단계: log_error.txt를 logs/error/로 이동
```
[jeongho@localhost wildcard_file_practice]$ mv log_error.txt ./logs/error/

```
# 3단계: log_access.txt를 logs/access/로 이동
```
[jeongho@localhost wildcard_file_practice]$ mv log_access.txt ./logs/access
[jeongho@localhost wildcard_file_practice]$ ls -l ./logs/access/
```

# 4단계: log_system.txt를 logs/system/로 이동
```
# 명령어들을 작성하세요:
[jeongho@localhost wildcard_file_practice]$ mv log_system.txt ./logs/system/
[jeongho@localhost wildcard_file_practice]$ ls -l ./logs/system/

```




#6. 고급 와일드카드 실습
- 6-1. 복잡한 패턴 매칭
- "report" 또는 "data"로 시작하고 숫자가 포함된 모든 파일을 찾아서 processed 디렉터리로 복사하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ cp report*[0-9]* data*[0-9]* processed/
```


# 6-2. 제외 패턴 활용
- 모든 파일 중에서 "final_"로 시작하지 않는 .txt 파일들을 draft 디렉터리로 이동하세요
```
# 명령어를 작성하세요:
[jeongho@localhost wildcard_file_practice]$ mv [!f]*.txt draft/
```



6-3. 범위 지정 패턴
# 파일명에 001부터 009까지의 숫자가 포함된 파일들을 single_digit 디렉터리로 복사하세요

```
# 명령어를 작성하세요:
```

# 7. 실전 시나리오 문제
- 7-1. 프로젝트 정리 시나리오
# 시나리오: 프로젝트 종료 후 파일 정리

# 1. 완료된 리포트 파일들(report*.txt)을 completed 디렉터리로 이동
```
[jeongho@localhost wildcard_file_practice]$ mkdir completed
[jeongho@localhost wildcard_file_practice]$ cd ./documents/
[jeongho@localhost documents]$ ls
changelog.md  presentation.ppt  report1.txt  report3.txt
document.pdf  readme.md         report2.txt  spreadsheet.xls
[jeongho@localhost documents]$ ls -l report*.txt 
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 17:59 report1.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 17:59 report2.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 17:59 report3.txt
[jeongho@localhost documents]$ mv report*.txt ../completed/
[jeongho@localhost documents]$ ls
changelog.md  document.pdf  presentation.ppt  readme.md  spreadsheet.xls
[jeongho@localhost documents]$ cd ..
[jeongho@localhost wildcard_file_practice]$ ls -l ./completed/
```
# 2. 작업 중인 파일들(temp*, *_draft)을 ongoing 디렉터리로 이동

# 3. 백업 파일들(backup_*)을 archive 디렉터리로 이동
```
[jeongho@localhost wildcard_file_practice]$ mv backup_*.* ./archives/
mv: cannot stat 'backup_*.*': No such file or directory
[jeongho@localhost wildcard_file_practice]$ ls
archives  backup_2   documents         images     scripts
backup    completed  draft             logs       temp
backup_1  data       final_report.txt  processed
[jeongho@localhost wildcard_file_practice]$ mv backup_* ./archives/
[jeongho@localhost wildcard_file_practice]$ ls
archives  completed  documents  final_report.txt  logs       scripts
backup    data       draft      images            processed  temp
[jeongho@localhost wildcard_file_practice]$ ls -l ./archives/
total 0
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:56 backup_1
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 19:56 backup_2
drwxr-xr-x. 2 jeongho jeongho 6 Jul 17 18:47 backup_2020
drwxr-xr-x. 2 jeongho jeongho 6 Jul 17 18:47 backup_2021
drwxr-xr-x. 2 jeongho jeongho 6 Jul 17 18:47 backup_2022
drwxr-xr-x. 2 jeongho jeongho 6 Jul 17 18:47 backup_2023
drwxr-xr-x. 2 jeongho jeongho 6 Jul 17 18:47 backup_2023.tar
drwxr-xr-x. 2 jeongho jeongho 6 Jul 17 18:47 backup_2024
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 18:48 new_report.txt
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 18:48 old_report.txt
[jeongho@localhost wildcard_file_practice]$ 
```
# 4. 불필요한 임시 파일들(*.tmp)을 삭제
```
[jeongho@localhost wildcard_file_practice]$ touch 1.tmp 2.tmp 3.tmp
[jeongho@localhost wildcard_file_practice]$ ls
1.tmp  archives   data       final_report.txt  processed
2.tmp  backup     documents  images            scripts
3.tmp  completed  draft      logs              temp
[jeongho@localhost wildcard_file_practice]$ rm *.tmp

```

# 7-2. 로그 관리 시나리오
시나리오: 서버 로그 정리

- 1. 2024년 로그 파일들을 logs/2024 디렉터리로 이동
```

```
- 2. 에러 로그들을 logs/errors 디렉터리로 복사
```
jeongho@localhost wildcard_file_practice]$ ls -l ./logs/log_error.txt 
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 18:14 ./logs/log_error.txt
[jeongho@localhost wildcard_file_practice]$ cp  ./logs/log_error.txt  ./logs/error/
[jeongho@localhost wildcard_file_practice]$ ls 


```
- 3. 2023년 로그 파일들을 삭제
```
[jeongho@localhost wildcard_file_practice]$ mv ./logs/log_system.txt ./logs/system/
[jeongho@localhost wildcard_file_practice]$ ls -l ./logs/system/
total 0
-rw-r--r--. 1 jeongho jeongho 0 Jul 17 18:14 log_system.txt
[jeongho@localhost wildcard_file_practice]$ 

```
- 4. 시스템 로그들을 logs/system 디렉터리로 이동


# 7-3. 개발 환경 정리 시나리오
## 시나리오: 개발 프로젝트 구조 정리

## 1. 모든 스크립트 파일(*.sh)을 scripts 디렉터리로 이동

## 2. 설정 파일들(*.conf, *.config)을 config 디렉터리로 복사

## 3. 문서 파일들(*.md, *.txt)을 docs 디렉터리로 이동

## 4. 데이터 파일들(*.csv, *.dat)을 data 디렉터리로 이동




#8. 보너스 문제
## 8-1. 한 줄 명령어 도전
모든 이미지 파일을 images 디렉터리로 이동하고, 
모든 문서 파일을 docs 디렉터리로 이동하는 작업을 
한 줄의 명령어로 실행하세요 (세미콜론 또는 && 사용)
```
[jeongho@localhost wildcard_file_practice]$ mv *.{jpg,img} ./images/ && mv *.txt ./documents/
```

# 8-2. 조건부 실행
images 디렉터리가 존재하면 모든 .jpg 파일을 이동하고,
존재하지 않으면 디렉터리를 생성한 후 이동하는 명령어를 작성하세요


# 8-3. 파일 개수 확인 후 실행
txt 파일이 5개 이상 있으면 backup 디렉터리로 복사하고,
그렇지 않으면 "파일이 부족합니다" 메시지를 출력하세요




# 9. 검증 명령어
각 문제를 해결한 후 다음 명령어들로 결과를 확인하세요:

# 디렉터리 구조 확인

ls -la

# 특정 디렉터리 내용 확인

ls -la backup/

ls -la images/

ls -la documents/

# 파일 개수 확인

ls *.txt | wc -l

ls *.jpg | wc -l

# 전체 파일 목록 확인

find . -type f | sort


10. 주의사항
⚠️ 실습 시 주의사항:

rm 명령어 사용 시 특히 주의하세요
중요한 파일은 미리 백업하세요
와일드카드 패턴이 의도한 파일들만 선택하는지 먼저 ls 명령어로 확인하세요
실제 서버에서는 더욱 신중히 실행하세요

패턴 확인 방법:

# 실제 명령 실행 전에 패턴이 올바른지 확인

echo cp *.txt backup/    # 실제로는 실행되지 않고 명령어만 출력

ls *.txt                 # 선택될 파일들 미리 확인


힌트
{} 중괄호 확장 활용: mkdir {dir1,dir2,dir3}
[] 문자 범위 활용: [1-3], [a-z]
* 와일드카드 활용: file*, *.txt
? 단일 문자 활용: file?.txt
복합 패턴 활용: *[0-9]*, file[1-3].txt
디렉터리 생성 시 -p 옵션 활용: mkdir -p path/to/directory

