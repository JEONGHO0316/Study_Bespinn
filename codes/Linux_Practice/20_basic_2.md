# 리눅스 상대 주소 실습 문제
- 사전 준비: 실습 환경 설정
- 다음 명령어로 실습 환경을 준비하세요
``` 
[jeongho@localhost ~]$ mkdir -p ~/practice/project/{src,docs,tests,config}
[jeongho@localhost ~]$ mkdir -p ~/practice/project/src/{main,utils}
[jeongho@localhost ~]$ mkdir -p ~/practice/project/docs/{user,dev}
[jeongho@localhost ~]$ mkdir -p ~/practice/project/tests/unit
[jeongho@localhost ~]$ touch ~/practice/project/README.md
[jeongho@localhost ~]$ touch ~/practice/project/src/main/app.py
[jeongho@localhost ~]$ touch ~/practice/project/src/utils/helper.py
[jeongho@localhost ~]$ touch ~/practice/project/docs/user/manual.txt
[jeongho@localhost ~]$ touch ~/practice/project/docs/dev/api.md
[jeongho@localhost ~]$ touch ~/practice/project/tests/test_main.py
[jeongho@localhost ~]$ touch ~/practice/project/config/settings.conf
``` 

# 완성된 디렉토리 구조:
```
├── practice
│   └── project
│       ├── config
│       │   └── settings.conf
│       ├── docs
│       │   ├── dev
│       │   │   └── api.md
│       │   └── user
│       │       └── manual.txt
│       ├── README.md
│       ├── src
│       │   ├── main
│       │   │   └── app.py
│       │   └── utils
│       │       └── helper.py
│       └── tests
│           ├── test_main.py
│           └── unit
```


# 연습문제 1: 기본 상대 주소 이해
- helper.py 파일
- README.md 파일
- manual.txt 파일
- settings.conf 파일
## 1-2. 상대 주소 검증
- 위에서 작성한 상대 주소가 정확한지 다음 명령어로 확인하시오:
- cd ~/practice/project/src/main/
- ls [상대주소]
```
[jeongho@localhost ~]$ cd ~/practice/project/src/main/
[jeongho@localhost main]$ ls
app.py
[jeongho@localhost main]$ ls ../
main  utils
[jeongho@localhost main]$ ls ../../
config  docs  README.md  src  tests
[jeongho@localhost main]$ ls ../../src/utils/
helper.py
[jeongho@localhost main]$ ls ../../docs/user/
manual.txt
[jeongho@localhost main]$ ls ../../config/
settings.conf
[jeongho@localhost main]$ 
```

# 연습문제 2: 다양한 시작점에서의 상대 주소
## 2-1. 시작점 변경 실습
## 현재 위치가 ~/practice/project/docs/user/일 때:
- app.py 파일로 이동하는 상대 주소를 작성하시오.
```
[jeongho@localhost user]$ cd ../../src/main/
[jeongho@localhost main]$ ls
app.py

```
- test_main.py 파일을 상대 주소를 작성하시오.
```
[jeongho@localhost main]$ cd ../../tests/
[jeongho@localhost tests]$ ls
test_main.py  unit
[jeongho@localhost tests]$
```
- src/utils/ 디렉토리로 이동하는 상대 주소를 작성하시오.
```
[jeongho@localhost tests]$ cd ../src/utils/
[jeongho@localhost utils]$
```

## 2-2. 역방향 상대 주소
- 현재 위치가 ~/practice/project/tests/unit/일 때:
- 프로젝트 루트(~/practice/project/)로 이동하는 상대 주소를 작성하시오.
```
[jeongho@localhost utils]$ cd ../../
[jeongho@localhost project]$ 

```
- api.md 파일로 이동하는 상대 주소를 작성하시오.
```
[jeongho@localhost utils]$ cd ../../
[jeongho@localhost project]$ cd ./docs/dev/
[jeongho@localhost dev]$ ls
api.md
```
- helper.py 파일을 상대 주소를 작성하시오.
```
[jeongho@localhost dev]$ cd ../../src/utils/
[jeongho@localhost utils]$ ls
helper.py
[jeongho@localhost utils]$ 

```

# 연습문제 3: 파일 내용 확인 및 조작
## 3-1. 상대 주소를 이용한 파일 내용 출력
### 현재 위치가 ~/practice/project/src/utils/일 때:
- 프로젝트 루트의 README.md 파일 내용을 출력하시오.
```
[jeongho@localhost utils]$ cat ../../README.md 
```
- docs/user/manual.txt 파일 내용을 출력하시오.
```
[jeongho@localhost utils]$ cat ../../docs/user/manual.txt
```
- config/settings.conf 파일 내용을 출력하시오.
```
[jeongho@localhost utils]$ cat ../../config/settings.conf
```

## 3-2. 상대 주소를 이용한 파일 생성
- 현재 위치가 ~/practice/project/src/main/일 때:
- 현재 디렉토리에 config.py 파일을 생성하고 "# Configuration module"이라는 내용을 작성하시오.
```
[jeongho@localhost main]$ cat >> config.py
#Configuration module

```
- tests/ 디렉토리에 test_app.py 파일을 생성하고 "# App test file"이라는 내용을 작성하시오.
```
[jeongho@localhost main]$ cat >> ../../tests/ test_app.py
bash: ../../tests/: Is a directory
[jeongho@localhost main]$ cat >> ../../tests/test_app.py
#App test file
[jeongho@localhost main]$ ls ../../tests/test_app.py 
../../tests/test_app.py
[jeongho@localhost main]$ cat  ../../tests/test_app.py
#App test file

```


# 연습문제 4: 파일 복사 및 이동
## 4-1. 상대 주소를 이용한 파일 복사
### 현재 위치가 ~/practice/project/docs/dev/일 때:
- api.md 파일을 docs/user/ 디렉토리에 api_copy.md로 복사하시오.
```
[jeongho@localhost dev]$ cp api.md ../api_copy.md
[jeongho@localhost dev]$ ls ../
api_copy.md  dev  user
[jeongho@localhost dev]$ ls
api.md
[jeongho@localhost dev]$ 
```
- src/utils/helper.py 파일을 현재 디렉토리에 복사하시오.
```
[jeongho@localhost dev]$ cp ../../src/utils/helper.py ./
[jeongho@localhost dev]$ ls
api.md  helper.py
```
- config/settings.conf 파일을 tests/unit/ 디렉토리에 복사하시오.
```
[jeongho@localhost dev]$ cp ../../config/settings.conf ../../tests/unit/
[jeongho@localhost dev]$ ls ../../tests/unit/
settings.conf
```

# 4-2. 상대 주소를 이용한 파일 이동
## 현재 위치가 ~/practice/project/tests/일 때:
- test_main.py 파일을 tests/unit/ 디렉토리로 이동하시오.
```
[jeongho@localhost tests]$ mv test_main.py ./unit/
[jeongho@localhost tests]$ ls
test_app.py  unit
[jeongho@localhost tests]$ ls ./unit/
settings.conf  test_main.py

```
- src/main/config.py 파일을 config/ 디렉토리로 이동하시오.
```
[jeongho@localhost tests]$ mv ../src/main/config.py ../config/
[jeongho@localhost tests]$ ls ../config/
config.py  settings.conf
[jeongho@localhost tests]$
```

# 연습문제 5: 복합 상대 주소 활용
## 5-1. 다중 파일 조작
- 현재 위치가 ~/practice/project/일 때:
- src/main/ 디렉토리의 모든 파일을 docs/dev/ 디렉토리에 복사하시오.
```
[jeongho@localhost project]$ cp src/main/*.py docs/dev/
[jeongho@localhost project]$ ls ./docs/dev/
api.md  app.py  helper.py  main
```
- docs/user/ 디렉토리의 모든 파일을 tests/unit/ 디렉토리로 이동하시오.
```
[jeongho@localhost project]$ mv ./docs/user/manual.txt ./tests/unit
[jeongho@localhost project]$ ls ./tests/unit/
manual.txt  settings.conf  test_main.py  user
[jeongho@localhost project]$ 



```
- config/ 디렉토리 전체를 backup_config/로 복사하시오.
```
[jeongho@localhost project]$ cp -r ./config/ ./backup_config/
[jeongho@localhost project]$ ls ./backup_config/
config

```

# 5-2. 조건부 파일 검색
## 현재 위치가 ~/practice/project/src/utils/일 때:
- 프로젝트 전체에서 .py 확장자를 가진 파일을 모두 찾으시오.
- docs/ 디렉토리에서 .md 확장자를 가진 파일을 모두 찾으시오.
- 현재 디렉토리에서 상위 2단계 디렉토리까지 .txt 파일을 모두 찾으시오.

# 연습문제 6: 에러 찾기 및 수정
## 6-1. 잘못된 상대 주소 찾기
- 현재 위치가 ~/practice/project/docs/user/일 때, 다음 명령어들 중 에러가 있는 것을 찾고 올바른 명령어로 수정하시오:

# D
cp manual.txt ../../tests/unit/backup.txt
```
cp manual.txt ../../tests/unit/
```


# E
mv api_copy.md ../../../src/main/
```
[jeongho@localhost user]$ mv ../dev/api.md ../../src/main/
```

# 6-2. 경로 최적화
### 다음 상대 주소를 더 간단하게 최적화하시오:
### 현재 위치: ~/practice/project/tests/unit/
- ../../src/main/../utils/helper.py
```
cat ../../src/utils/helper.py 
```
- ../../docs/user/../dev/api.md
```
[jeongho@localhost unit]$ cat ../../docs/dev/api.md
```
- ../../config/../README.md
```
[jeongho@localhost unit]$ cat ../../README.md
```
# 연습문제 7: 종합 실습
## 7-1. 프로젝트 구조 재정리
- 현재 위치가 ~/practice/project/일 때, 다음 작업을 수행하시오:
- src/main/ 디렉토리에 models/ 하위 디렉토리를 생성하시오.
```
[jeongho@localhost project]$ mkdir ./src/main/models
```
- docs/ 디렉토리에 README.md 파일을 생성하고 "# Project Documentation"이라는 내용을 작성하시오.
```
[jeongho@localhost project]$ cat >> ./docs/README.md
#Project Documentation
[jeongho@localhost project]$ cat ./docs/README.md 
#Project Documentation

```
- tests/unit/ 디렉토리의 모든 파일을 tests/ 디렉토리로 이동하시오.
```
[jeongho@localhost project]$ mv tests/unit/* tests/
```
- config/ 디렉토리의 모든 파일을 src/ 디렉토리에 복사하시오.
```
[jeongho@localhost project]$ cp -r ./config/ ./src/

```

# 7-2. 백업 및 정리
- 현재 위치가 ~/practice/project/src/main/일 때:
- 현재 내용을 ../../project_backup/으로 복사하시오.
```
[jeongho@localhost main]$ cp -r . ../../project_backup/
```
- utils/ 디렉토리의 모든 .py 파일을 현재 디렉토리의 models/ 디렉토리로 복사하시오.
```
[jeongho@localhost main]$ cp ../utils/*.py ./models/
```
- 프로젝트 루트의 README.md 파일을 현재 디렉토리에 PROJECT_INFO.md로 복사하시오.
```
[jeongho@localhost main]$ cp ../../README.md ./PROJECT_INFO.md
```




