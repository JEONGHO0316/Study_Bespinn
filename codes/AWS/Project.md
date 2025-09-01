```
CPU사용량 60% 이상시 내 슬랙 계정에 알림 보내는 스크립트
#!/bin/bash
# -----------------------------
# 설정
#!/bin/bash
# -----------------------------
# 설정
# -----------------------------
LOG_DIR="/home/ec2-user/logs"
SLACK_WEBHOOK="내 슬랙 ID"
CPU_THRESHOLD=60       # CPU 임계값 60%
ALERT_INTERVAL=10    # Slack 알림 최소 간격(초)
mkdir -p "$LOG_DIR"

# -----------------------------
# 초기 변수
# -----------------------------
LAST_ALERT=0

# -----------------------------
# 메인 루프
# -----------------------------
while true; do
    DATE_NOW=$(date '+%Y-%m-%d %H:%M:%S')
    LOG_FILE="$LOG_DIR/$(date +'%Y%m%d').log"

    # -----------------------------
    # 시스템 정보 수집
    # -----------------------------
    if command -v mpstat >/dev/null 2>&1; then
        CPU=$(mpstat 1 1 | awk '/Average/ {printf "%.2f", 100 - $NF}')
    else
        CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    fi

    MEM=$(free | awk '/Mem/ {printf "%.2f", $3/$2 * 100}')
    DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    echo "$DATE_NOW CPU: $CPU% MEM: $MEM% DISK: $DISK%" >> "$LOG_FILE"

    # -----------------------------
    # CPU 임계값 체크 (Slack 알림)
    # -----------------------------
    if (( $(echo "$CPU > $CPU_THRESHOLD" | bc -l) )); then
        NOW=$(date +%s)
        if (( NOW - LAST_ALERT > ALERT_INTERVAL )); then
            ALERT_MSG="$DATE_NOW CPU 사용량 경고: $CPU%"
             curl -s -X POST -H 'Content-type: application/json' \
                --data "{\"text\":\"$ALERT_MSG\"}" \
                "$SLACK_WEBHOOK"
            LAST_ALERT=$NOW
        fi
    fi

    sleep 5
done
```
```
명령어 실행 
**nohup stress-ng --cpu 4 --cpu-load 60 --timeout 60s > cpu_load.log 2>&1 &**

**nohup ./log_monitor.sh > log_monitorr.log 2>&1 &**
```