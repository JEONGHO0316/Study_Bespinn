
### DB 연결 자동화 스크립트 

```
#!/bin/bash

# ------------------------------------------------------------------
# 변수 설정 (Terraform에서 넘어온 값들)
# ------------------------------------------------------------------
DB_USER="${id}"
DB_PASS="${pw}"
DB_HOST="${endpoint}"
DB_NAME="${db_name}"   
TABLE_NAME="address"  

# ------------------------------------------------------------------
# 1. 테이블 존재 여부 확인 
# ------------------------------------------------------------------
# information_schema를 조회해서 해당 테이블이 몇 개인지 셉니다. (0 or 1)
EXIST_COUNT=$(mysql -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" -N -s -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$DB_NAME' AND table_name='$TABLE_NAME';")

# ------------------------------------------------------------------
# 2. 조건부 실행 (없을 때만 실행)
# ------------------------------------------------------------------
if [ "$EXIST_COUNT" -eq 0 ]; then
  echo "[Terraform UserData] 테이블($TABLE_NAME)이 없습니다. 초기화를 시작합니다..."
  
  mysql -u "$DB_USER" -p"$DB_PASS" -h "$DB_HOST" "$DB_NAME" < /var/www/html/sql/addressbook.sql
  
  echo "[Terraform UserData] 초기화 완료!"
else
  echo "[Terraform UserData] 테이블($TABLE_NAME)이 이미 존재합니다. 기존 데이터를 보호하기 위해 SQL 실행을 건너뜁니다."
fi
```