
### kubectl run apache --image=httpd:latest --port=80 --dry-run=client -o yaml
 - 자동 생성된 매니페스트 형태 yaml 
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: apache
  name: apache
spec:
  containers:
  - image: httpd:latest
    name: apache
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

### vi httpd-pod.yaml 
 - 직접 작성한 yaml 파일 
```
apiVersion: v1
kind: Pod
metadata:
  name: apache
spec:
  containers:
  - image: httpd
    name: httpd
    ports:
    - containerPort: 80
```

### 경량 버젼의 Apache 웹서버 
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: apache
  name: apache
spec:
  containers:
  - image: httpd:2.4-alpine
    name: apache
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```