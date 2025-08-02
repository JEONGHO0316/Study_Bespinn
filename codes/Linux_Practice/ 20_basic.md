# 기본 명령어 연습 문제

## 📁 Level 1: 기본 탐색 및 폴더 조작
 - ### 문제 1-1: 현재 위치 확인
 - ### 현재 작업 중인 디렉터리의 경로를 확인하세요

```
PS C:\Develops\quest> pwd

Path
----
C:\Develops\quest
```

### 문제 1-2: 폴더 구조 만들기
 - 다음 폴더 구조를 생성하세요:

```
PS C:\Develops\quest\powershell_practice> tree
폴더 PATH의 목록입니다.
볼륨 일련 번호는 52B6-33C5입니다.
C:.
├─backup
├─documents
├─images
└─temp
``` 

### 문제  1-3
```
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\documents
PS C:\Develops\quest\powershell_practice\documents> ls
PS C:\Develops\quest\powershell_practice\documents> cd ..
PS C:\Develops\quest\powershell_practice>
```

# 📄 Level 2: 파일 생성 및 조작
### 문제 2-1: 텍스트 파일 생성

``` 
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\documents
PS C:\Develops\quest\powershell_practice\documents> "hello" > hello.txt
PS C:\Develops\quest\powershell_practice\documents> "Hello PowerShell!" > hello.txt
PS C:\Develops\quest\powershell_practice\documents> cd ..
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\images
PS C:\Develops\quest\powershell_practice\images> "" > photo1.jpg
PS C:\Develops\quest\powershell_practice\images> "" > photo2.png
PS C:\Develops\quest\powershell_practice\images> cd ..
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\documents
PS C:\Develops\quest\powershell_practice\documents> tree
폴더 PATH의 목록입니다.
볼륨 일련 번호는 52B6-33C5입니다.
C:.

에 하위 폴더가 없습니다.
PS C:\Develops\quest\powershell_practice\documents> ls


    디렉터리: C:\Develops\quest\powershell_practice\documents


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:39             40 hello.txt


PS C:\Develops\quest\powershell_practice\documents> echo "Hello PowerShell!" > hello.txt
PS C:\Develops\quest\powershell_practice\documents> ls


    디렉터리: C:\Develops\quest\powershell_practice\documents


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:42             40 hello.txt

```

### 문제 2-2: 파일 내용 확인
```
PS C:\Develops\quest\powershell_practice\documents> Get-Content hello.txt -encoding utf8
Hello PowerShell!
PS C:\Develops\quest\powershell_practice\documents>
```

### 문제 2-3: 파일 복사
```

PS C:\Develops\quest\powershell_practice\documents> mv hello.txt C:\Develops\quest\powershell_practice\backup
PS C:\Develops\quest\powershell_practice\documents> ls
PS C:\Develops\quest\powershell_practice\documents> cp hello.txt  C:\Develops\quest\powershell_practice\backup
PS C:\Develops\quest\powershell_practice\documents> cd ..
PS C:\Develops\quest\powershell_practice> cd  C:\Develops\quest\powershell_practice\images
PS C:\Develops\quest\powershell_practice\images> ls


    디렉터리: C:\Develops\quest\powershell_practice\images


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:39              6 photo1.jpg
-a----      2025-07-15   오후 3:39              6 photo2.png


PS C:\Develops\quest\powershell_practice\images> cp photo1.jpg C:\Develops\quest\powershell_practice\backup
PS C:\Develops\quest\powershell_practice\images> cp photo2.png C:\Develops\quest\powershell_practice\backup
PS C:\Develops\quest\powershell_practice\images> cd..
PS C:\Develops\quest\powershell_practice> cd  C:\Develops\quest\powershell_practice\backup
PS C:\Develops\quest\powershell_practice\backup> ls


    디렉터리: C:\Develops\quest\powershell_practice\backup


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:42             40 hello.txt
-a----      2025-07-15   오후 3:39              6 photo1.jpg
-a----      2025-07-15   오후 3:39              6 photo2.png


PS C:\Develops\quest\powershell_practice\backup>
```

 # Level 3: 파일 이동 및 이름 변경
 ### 문제 3-1: 파일 이동

```
PS C:\Develops\quest\powershell_practice\backup> cd..
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\temp
PS C:\Develops\quest\powershell_practice\temp> "" > test.txt
PS C:\Develops\quest\powershell_practice\temp> mv test.txt C:\Develops\quest\powershell_practice\documents
PS C:\Develops\quest\powershell_practice\temp> cd..
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\documents
PS C:\Develops\quest\powershell_practice\documents> ls


    디렉터리: C:\Develops\quest\powershell_practice\documents


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:42             40 hello.txt
-a----      2025-07-15   오후 3:54              6 test.txt


PS C:\Develops\quest\powershell_practice\documents>


```

### 문제 3-2: 파일 이름 변경

```
PS C:\Develops\quest\powershell_practice\documents> mv test.txt moved_file.txt
PS C:\Develops\quest\powershell_practice\documents> ls


    디렉터리: C:\Develops\quest\powershell_practice\documents


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:42             40 hello.txt
-a----      2025-07-15   오후 3:54              6 moved_file.txt


PS C:\Develops\quest\powershell_practice\documents> cd ..
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\images
PS C:\Develops\quest\powershell_practice\images> mv photo1.jpg picture1.jpg
PS C:\Develops\quest\powershell_practice\images> ls


    디렉터리: C:\Develops\quest\powershell_practice\images


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:39              6 photo2.png
-a----      2025-07-15   오후 3:39              6 picture1.jpg


PS C:\Develops\quest\powershell_practice\images>

```

### 문제 3-3: 폴더 이름 변경
```
PS C:\Develops\quest\powershell_practice\images> cd..
PS C:\Develops\quest\powershell_practice> mv temp temporary
PS C:\Develops\quest\powershell_practice> ls


    디렉터리: C:\Develops\quest\powershell_practice


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-15   오후 3:49                backup
d-----      2025-07-15   오후 3:58                documents
d-----      2025-07-15   오후 3:59                images
d-----      2025-07-15   오후 3:55                temporary


PS C:\Develops\quest\powershell_practice>
```

# 🗑️ Level 4: 삭제 연습
### 문제 4-1: 개별 파일 삭제
```
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\documents
PS C:\Develops\quest\powershell_practice\documents> rm moved_file.txt
PS C:\Develops\quest\powershell_practice\documents> ls


    디렉터리: C:\Develops\quest\powershell_practice\documents


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:42             40 hello.txt


PS C:\Develops\quest\powershell_practice\documents> cd ..
PS C:\Develops\quest\powershell_practice> cd C:\Develops\quest\powershell_practice\images
PS C:\Develops\quest\powershell_practice\images> rm photo2.png
PS C:\Develops\quest\powershell_practice\images> ls


    디렉터리: C:\Develops\quest\powershell_practice\images


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 3:39              6 picture1.jpg


PS C:\Develops\quest\powershell_practice\images>

```

### 문제 4-2: 폴더 삭제
```
PS C:\Develops\quest\powershell_practice\images> cd ..
PS C:\Develops\quest\powershell_practice> rmdir temporary
PS C:\Develops\quest\powershell_practice> rmdir backup

확인
C:\Develops\quest\powershell_practice\backup의 항목에는 하위 항목이 있으며 Recurse 매개 변수를
지정하지 않았습니다. 계속하면 해당 항목과 모든 하위 항목이 제거됩니다. 계속하시겠습니까?
[Y] 예(Y)  [A] 모두 예(A)  [N] 아니요(N)  [L] 모두 아니요(L)  [S] 일시 중단(S)  [?] 도움말
(기본값은 "Y"):Y
PS C:\Develops\quest\powershell_practice> ls


    디렉터리: C:\Develops\quest\powershell_practice


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-15   오후 4:12                documents
d-----      2025-07-15   오후 4:12                images


PS C:\Develops\quest\powershell_practice>
```

 # Level 5: 종합 응용
### 문제 5-1: 프로젝트 구조 만들기
다음과 같은 프로젝트 구조를 생성하세요:
```
PS C:\Develops\quest\my_project> tree
폴더 PATH의 목록입니다.
볼륨 일련 번호는 52B6-33C5입니다.
C:.
├─build
├─docs
├─src
│  └─main.py
└─tests
PS C:\Develops\quest\my_project>

```


### 문제 5-2: 파일 정리
```
PS C:\Develops\quest\my_project> cd C:\Develops\quest\my_project\src
PS C:\Develops\quest\my_project\src> ls


    디렉터리: C:\Develops\quest\my_project\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 4:20             46 main.py


PS C:\Develops\quest\my_project\src> cp main.py C:\Develops\quest\my_project\build
PS C:\Develops\quest\my_project\src> cd C:\Develops\quest\my_project\build
PS C:\Develops\quest\my_project\build> ls


    디렉터리: C:\Develops\quest\my_project\build


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 4:20             46 main.py


PS C:\Develops\quest\my_project\build> cd ..
PS C:\Develops\quest\my_project> cd C:\Develops\quest\my_project\docs
PS C:\Develops\quest\my_project\docs> mv readme.txt project_info.txt
PS C:\Develops\quest\my_project\docs> ls


    디렉터리: C:\Develops\quest\my_project\docs


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 4:18             42 project_info.txt


PS C:\Develops\quest\my_project\docs> cd
PS C:\Develops\quest\my_project\docs> cd ..
PS C:\Develops\quest\my_project> rmdir tests
PS C:\Develops\quest\my_project> ls


    디렉터리: C:\Develops\quest\my_project


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----      2025-07-15   오후 4:26                build
d-----      2025-07-15   오후 4:27                docs
d-----      2025-07-15   오후 4:24                src


PS C:\Develops\quest\my_project>

```

### 문제 5-3: 최종 확인
- my_project 폴더의 모든 하위 내용을 재귀적으로 확인하세요

```
PS C:\Develops\quest\my_project> tree
폴더 PATH의 목록입니다.
볼륨 일련 번호는 52B6-33C5입니다.
C:.
├─build
├─docs
└─src
PS C:\Develops\quest\my_project>
```

- 각 폴더로 이동하여 파일 내용을 확인하세요
```
PS C:\Develops\quest\my_project> cd C:\Develops\quest\my_project\build
PS C:\Develops\quest\my_project\build> ls
PS C:\Develops\quest\my_project\build> cd ..
PS C:\Develops\quest\my_project> cd C:\Develops\quest\my_project\docs
PS C:\Develops\quest\my_project\docs> ls


    디렉터리: C:\Develops\quest\my_project\docs


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 4:18             42 project_info.txt


PS C:\Develops\quest\my_project\docs> cd ..
PS C:\Develops\quest\my_project> cd C:\Develops\quest\my_project\src
PS C:\Develops\quest\my_project\src> cd ..
PS C:\Develops\quest\my_project> cd C:\Develops\quest\my_project\src
PS C:\Develops\quest\my_project\src> ls


    디렉터리: C:\Develops\quest\my_project\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----      2025-07-15   오후 4:20             46 main.py


PS C:\Develops\quest\my_project\src>
```
