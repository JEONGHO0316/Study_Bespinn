자동화 스크립트 
--
1. 다운 받았던 Sample 디렉토리 삭제
2. github 에 있는 어플 복사 
3. 다운 받았던 곳으로 이동후 
4. 권한 설정
5. 백그라운드로 실행 
``` 
#!/bin/bash
rm -rf ./swu_stresstest_example
git clone https://github.com/dev-library/sd_day2_h2baseapp.git
cd ./sd_day2_h2baseapp/ || exit
chmod +x ./gradlew
nohup ./gradlew bootRun > app.log 2>&1 &
```