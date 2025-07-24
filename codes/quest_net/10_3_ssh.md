
# Shell 조건문 및 텍스트 처리 실습 문제
## 실습 환경 설정


## 실습 문제

### 문제 2: 서버 로그 모니터링 도구
- 파일: log_monitor.sh
- 요구사항:
- server_logs.txt 파일을 분석하여 로그 수준별 통계 및 문제 상황 감지
- 조건문을 사용하여 경고 수준 결정
- 구현해야 할 기능:
- 전체 로그 라인 수 출력
- ERROR, WARNING, INFO 각각의 개수 계산 및 출력
- ERROR 로그만 별도 파일(errors.log)로 저장
- 가장 많이 발생한 ERROR 유형 찾기 (중복 제거 후 개수 확인)
- ERROR 비율이 30% 이상이면 "위험", 20% 이상이면 "주의", 그 외는 "정상" 출력
- 마지막 5개 로그 항목을 시간 역순으로 출력
- 힌트:
- grep, wc, uniq, sort, tail 명령어 활용
- 리다이렉션으로 파일 저장
- 수치 계산을 위한 조건문 사용


```
[jeongho@localhost shell_practice]$ source ./log_monitor.sh 
전체 로그 라인 수: 12
ERROR 개수: 5
WARNING 개수: 2
INFO 개수: 5
가장 많이 발생한 ERROR 유형: Database connection failed 
경고 수준: 위험
최근 로그 5개 (시간 역순):
2024-01-15 10:41:35 ERROR Authentication failed: user005
2024-01-15 10:40:28 INFO User login successful: user004
2024-01-15 10:39:15 ERROR Database connection failed
2024-01-15 10:38:52 WARNING Disk space low: 90%
2024-01-15 10:37:45 INFO System backup started

```

```
#!/bin/bash

LOG_FILE="server_logs.txt"

# 파일 존재 확인
if [ ! -f "$LOG_FILE" ]; then
  echo "로그 파일이 존재하지 않습니다."
  exit 1
fi

TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "전체 로그 라인 수: $TOTAL_LINES"

ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")
WARNING_COUNT=$(grep -c "WARNING" "$LOG_FILE")
INFO_COUNT=$(grep -c "INFO" "$LOG_FILE")

echo "ERROR 개수: $ERROR_COUNT"
echo "WARNING 개수: $WARNING_COUNT"
echo "INFO 개수: $INFO_COUNT"


grep "ERROR" "$LOG_FILE" > errors.log


cut -d' ' -f4- errors.log | sort | uniq -c | sort -nr | head -1 | awk '{print "가장 많이 발생한
 ERROR 유형: "$2" "$3" "$4" "$5}'


ERROR_PERCENT=$(awk "BEGIN {printf \"%.0f\", ($ERROR_COUNT/$TOTAL_LINES)*100}")

if [ "$ERROR_PERCENT" -ge 30 ]; then
  echo "경고 수준: 위험"
elif [ "$ERROR_PERCENT" -ge 20 ]; then
  echo "경고 수준: 주의"
else
  echo "경고 수준: 정상"
fi


echo "최근 로그 5개 (시간 역순):"
tail -n 20 "$LOG_FILE" | sort -r | head -n 5
```