# S3 오브젝트 스토리지
### Test.txt 만들기
### 만든 s3 스토리지에 복사 하는데 IAM 권한 안줘서 실패
### 다시 권한 주고 시도 하니 성공
```
[ec2-user@ip-10-0-0-14 ~]$ nano test.txt
[ec2-user@ip-10-0-0-14 ~]$ cat test.txt 
This is text.txt
[ec2-user@ip-10-0-0-14 ~]$ aws s3 cp test.txt s3://sample-s3-jeongho/test.txt
upload failed: ./test.txt to s3://sample-s3-jeongho/test.txt Unable to locate credentials
[ec2-user@ip-10-0-0-14 ~]$ aws s3 cp test.txt s3://sample-s3-jeongho/test.txt
upload: ./test.txt to s3://sample-s3-jeongho/test.txt   
```
---
---


### 1. 주기적으로 로그 남기는 쉘 스크립트 작성 
 ### 1) date를 활용하면 시간을 기입한 로그를 남길수 있습니다
 ### 2) 5초 단위로 cpu사용량, 메모리 사용량, 디스크 사용량을 %로 표기해서 
   ###  yyyyMMdd-HHmm .log 파일에 기입해주세요
### 2. 남겨진 로그를 s3에 주기적으로 업로드하는 쉘 스크립트 작성
 ### 3) 매 분마다 남겨진 로그 파일을 s3 에 업로드 합니다
 ### 4) 업로드가 확인된 파일만 로컬에서 삭제합니다
 ### 5) 업로드 실패시, echo를 이용해서 "<파일명>파일 업로드에 실패했습니다."
 ### 라고 남깁니다 추후 webhook으로 슬랙에 남기도록 작성하면 더좋습니다
 ### 3. 위 2개 스크립트를 크론잡에 등록해서 실제로 잘 돌아가는 지 확인 


-  Stress 라는 도구가 잇음
-  검색해서 설치한 다음 해당 도구를 이용해서 메모리 사용량을 원하는 수준을 조절 할 수 있음 
 - 이를 통해서 임계값을 설정해놓고 넘기는게 관측되면 알림이 오거나 메일을 보내는 등의 조치를 수행 

```
#!/bin/bash

# -----------------------------
# 설정
# -----------------------------
S3_BUCKET="my bucket name"              # 내가 설정한 s3 버킷 이름
REGION="my region"                     # 내 리전 주소
LOG_DIR="/home/ec2-user/logs" 
SLACK_WEBHOOK="my address"             # 내 슬랙 주소
MEM_THRESHOLD=50                       # MEM 임계값 50%
UPLOAD_INTERVAL=60                     # S3 업로드 간격 (초)
mkdir -p "$LOG_DIR"

# -----------------------------
# 메인 루프
# -----------------------------
LAST_UPLOAD=0

while true; do
    DATE_NOW=$(date '+%Y-%m-%d %H:%M:%S')
    LOG_FILE="$LOG_DIR/$(date +'%Y%m%d-%H%M').log"

    # -----------------------------
    # 시스템 정보 수집
    # -----------------------------
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    MEM=$(free | grep Mem | awk '{printf "%.2f", $3/$2 * 100}')
    DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    echo "$DATE_NOW CPU: $CPU% MEM: $MEM% DISK: $DISK%" >> "$LOG_FILE"

    # -----------------------------
    # 메모리 임계값 체크
    # -----------------------------
    if (( $(echo "$MEM > $MEM_THRESHOLD" | bc -l) )); then
        ALERT_MSG="$DATE_NOW 메모리 사용량 경고: $MEM%"
        curl -s -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"$ALERT_MSG\"}" \
            "$SLACK_WEBHOOK"
    fi

    # -----------------------------
    # S3 업로드: 일정 간격마다 실행
    # -----------------------------
    CURRENT_TIME=$(date +%s)
    if (( CURRENT_TIME - LAST_UPLOAD >= UPLOAD_INTERVAL )); then
        for file in "$LOG_DIR"/*.log; do
            FILE_BASENAME=$(basename "$file")
            CURRENT_LOG_BASENAME=$(basename "$LOG_FILE")
            # 현재 로그 파일은 제외
            if [[ "$FILE_BASENAME" != "$CURRENT_LOG_BASENAME" ]]; then
                if aws s3 cp "$file" "$S3_BUCKET/" --region "$REGION"; then
                    rm -f "$file"
                else
                    ALERT_MSG="$DATE_NOW $file 파일 S3 업로드 실패"
                    curl -s -X POST -H 'Content-type: application/json' \
                        --data "{\"text\":\"$ALERT_MSG\"}" \
                        "$SLACK_WEBHOOK"
                fi
            fi
        done
        LAST_UPLOAD=$CURRENT_TIME
    fi

    sleep 5
done
```