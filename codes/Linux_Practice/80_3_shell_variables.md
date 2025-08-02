# 🧪 Shell Script 실습 문제 세트: "변수 중심 텍스트 분석"

# ✅ [문제 1] 파일 내 단어 수 세기
# 문제 설명
사용자로부터 파일명을 입력받고, 해당 파일의 단어 수를 계산해서 출력하는 스크립트를 작성하세요.

# 요구사항
- read 명령어로 파일명 입력
- 변수에 파일명 저장
- wc 명령어 사용

## 🔧 예시 실행:
```
bash wordcount.sh
Enter filename: sample.txt
Word count in sample.txt: 123
```
```
[jeongho@localhost env]$ source ./wordcount.sh 
filename : file2.txt
7 file2.txt

read -p "filename : " V_Filen
wc -w  "$V_Filen"

```
# ✅ [문제 2] 특정 단어 검색 및 빈도수 세기
## 문제 설명
스크립트 실행 시 단어(keyword)와 파일명을 인자로 받아 해당 단어의 등장 횟수를 출력하세요.
# 요구사항
- $1: 검색할 단어
- $2: 파일명
- grep, wc, 변수 사용

🔧 예시 실행:
bash count_keyword.sh error logfile.txt
The word 'error' appeared 5 times.
```
[jeongho@localhost env]$ source keyword.sh error logfile.txt 
16
The word error appeared 16 times
[jeongho@localhost env]$ 

V_Word="$1"
V_File="$2"

V_Count=$( grep -i "error" "$2"  | wc -w )
echo "The word "$1"  appeared "$V_Count" times."

```

# ✅ [문제 3] 고유 단어 목록 만들기
## 문제 설명
파일에서 고유한 단어만 추출하고, 정렬하여 새로운 파일로 저장하세요.

# 요구사항
- read 로 입력 받을 파일명
- cut, tr, sort, uniq 조합
- 변수 활용 및 리다이렉션 사용

🔧 예시 실행:
bash unique_words.sh
Enter input file: article.txt
Unique words saved to: article_unique.txt

```
[jeongho@localhost env]$ source ./unique_words.sh 
input file:article.txt
article.txt
Unique words saved to :article_unique.txt
article_unique.txt
[jeongho@localhost env]$ cat article_unique.txt 
an
automation.
developers
embedded
Many
open-source
operating
popular
programming
servers
system.
systems.
use
```
```
read -p "input file:" V_Filename
echo $V_Filename

read -p "Unique words saved to :"  V_Filename2 
echo $V_Filename2 

tr -s '[:space:]' '\n'< "$V_Filename" | sort | uniq -u  > "$V_Filename2"



```
# ✅ [문제 4] 두 파일의 마지막 줄 비교
## 문제 설명
- 두 개의 텍스트 파일을 인자로 받아 각각의 마지막 줄을 비교하고, 
- 같으면 "Same", 다르면 "Different" 출력

# 요구사항
- 인자 $1, $2 활용
- tail -n 1, diff 사용
- 임시 변수에 각 줄 저장

🔧 예시 실행:
bash compare_lastline.sh file1.txt file2.txt
Result: Different
```
[jeongho@localhost env]$ source ./compare_lastline.sh file1.txt file2.txt imsi
Diffre
[jeongho@localhost env]$ ls
article.txt         compare_lastline.sh  file2.txt  keyword.sh   people.txt       wordcount.sh
article_unique.txt  file1.txt            imsi       logfile.txt  unique_words.sh
[jeongho@localhost env]$ cat imsi
3c3
< Last line A
---
> Last line B


V_Textfile="$1"
V_Textfile="$2"
V_Textfile="$3"

tail -n1 "$1" "$2" | diff "$1" "$2"  >> "$3"


if [ "$1" =  "$2" ]; then
  echo "Same"
else 
  echo "Diffre"
fi


```

# ✅ [문제 5] 이메일 리스트 정제 및 카운트
## 문제 설명
- 이메일이 섞인 텍스트 파일에서 이메일 주소만 추출하고 도메인별 개수를 출력하는 - 스크립트 작성

# 요구사항
- read로 파일명 받기
- grep/awk, cut, sort, uniq -c 활용
- 결과를 정렬된 상태로 출력

🔧 예시 실행:
bash email_domains.sh
Enter file name: people.txt
```
Output:
5 gmail.com
3 naver.com
2 daum.net
```
```
[jeongho@localhost env]$ source ./email_dimains.sh 
Email File: people.txt
      3 naver.com
      3 gmail.com
      2 daum.net
```
```
read -p "Email File: " V_Em
 
cut -d@ -f2 "$V_Em" | sort | uniq -dc | sort -r | cut -d'>' -f1 
```



# ✅ [문제 6] 다단계 파이프라인 정제
# 문제 설명
사용자에게 파일명을 받아, 모든 단어를 소문자로 변환한 후, 단어 빈도수를 내림차순으로 정렬해 출력

# 요구사항
- read 사용
- 변수에 파일명 저장
- tr, sort, uniq -c, sort -nr 조합
- 파이프라인 필수

🔧 예시 실행:
bash word_freq_sort.sh
Enter file to process: document.txt
```
Output:
45 the  
30 and  
20 python  
```

```
[jeongho@localhost env]$ source word_freq_sort.sh 
FIle:article.txt
article.txt
      1 many developers use linux for programming and automation.
      1 linux is popular for servers and embedded systems.
      1 linux is an open-source operating system.
      1  
[jeongho@localhost env]$ 




read -p "FIle:" V_File

echo "$V_File"

cat "$V_File" | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr


```