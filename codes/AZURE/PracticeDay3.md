# Docker Test
```
#1. Azure에 연결 (또는 포털 로그)
az login

#2. 레지스트리용 리소스 그룹 만들기 (또는 기존 리소스 그룹)
az group create --name rg-containerlab --location koreacentral

#3. 기본 컨테이너 레지스트리를 만들기(또는 포털에서 만들기)
az acr create --resource-group rg-containerlab --name crhjh --sku Basic

#4. ACR 인스턴스에 로그인
az acr login --name crhjh

#5. 컨테이너 레지스트리 인스턴스의 전체 로그인 서버 이름 얻기
az acr list --resource-group rg-container --query "[].{acrLoginServer:loginServer}" --output table

#6. ACR로그인 서버의 정규화된 이름을 사용하여 이미지 태그 지정. 
#레지스트리에 이미지를 푸시하려면 먼저 ACR로그인 서버의 정규화된 이름을 태그로 사용해야 한다.
docker tag guestbook-app acrkdk.azurecr.io/guestbook:v1

#7 도커 이미지를 ACR에 등록하기
docker push acrkdk.azurecr.io/guestbook:v1

#8. 레지스트리의 리포지토리에서 업로드된 이미지 나열 (또는 포털 사용)
az acr repository list --name crhjh --output table

#9. 리포지토리의 태그 나열
az acr repository show-tags --name crhjh --repository guestbook --output table

#10. 컨테이너 레지스트리에서 guestbook-app:v1 컨테이너 이미지를 끌어와 실행
docker image rm crhjh.azurecr.io/guestbook:v1

docker run -p 8080:3000 -d --name iuguestbook crhjh.azurecr.io/guestbook:v1

#11. Admin 사용자 설정
#ACI나 AKS 등에서 ACR의 리포지토리를 액세스하려면 필수.
az acr update --name crhjh --admin-enabled true

#12. Admin 사용자의 암호 쿼리
az acr credential show --name crhjh --query "passwords[0].value"

#13. az cli로 빌드 및 배포를 한 방에 하기
az acr build  -t crhjh.azurecr.io/newguestbook:v2 -r crhjh .

#13. az cli로 빌드 및 배포를 한 방에 하기
az acr build --platform linux/amd64  -t crhjh.azurecr.io/newguestbook:v2 -r
crhjh . # mac 일때 추가 해줘야함 
```

# Jarvis Html File
```
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>자비스</title>
    <link rel="stylesheet" href="bootstrap.min.css" />
    <style>
    </style>
    <script src="bootstrap.min.js">
    </script>
    
</head>
<body>
    <div class="container">
        <h1 class="display-4 mb-4">자비스 v 1.0</h1>
        <hr>
        <div id="output"></div>
        <form id="submitMessage">
          <div class="form-group">
            <input type="text" id="prompt" class="form-control" placeholder="프롬프트를 입력하세요...">
          </div>
          <input type="submit" class="btn btn-secondary" onclick="submitMessage(event)" value="전송">
        </form>
    </div>
    <script>
        function submitMessage(e) {
            e.preventDefault();
        
            const prompt = document.getElementById('prompt').value;

            fetch(`http://172.16.2.4:3000/api/ask?prompt=${prompt}`, {
                method: 'GET',
            })
            .then(function(response) {
                if (response.status === 200) {
                    response.text().then(text => updateUI(text)); 
                } else {
                    updateError();
                }
            })
        }
        
        function updateUI(text)
        {
            const output = `
            <div class="alert alert-success" role="alert">
                ${text}
            </div>`;
            document.getElementById('output').innerHTML = output;
        }

        function updateError(errorMessage = '프롬프트가 없거나 잘못된 프롬프트 입니다. :(')
        {
            const output = `
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>`;
            document.getElementById('output').innerHTML = output;
        }
    </script>
</body>
</html>
```

# Jarvis Back
```
[Back-End API]

#1. NodeJS 설치
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs build-essential

#2. 노드 버전 확인
node --version

#3. 작업 디렉터리 만들기
mkdir api

#4. 파일 공유 서비스에 파일 업로드
server.js
.env

#5. 파일 공유의 파일을 작업 디렉터리로 복사
cd /user/tony/api
cp /mnt/bedatashare/server.js .env .

#6. 패키지 설치
npm install @azure/openai@1.0.0-beta.12
npm install dotenv

#6. server.js 백그라운드로 실행
node server.js &
```