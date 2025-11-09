
### nginx-pod.yaml
- 직접 작성한 yaml 파일 
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
      - containerPort: 80
```

----------------------
### kubectl run apache --image=httpd:latest --port=80 --dry-run=client -o yaml
 - 자동 생성된 매니페스트 형태 yaml 
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: web
  name: web
spec:
  containers:
  - image: nginx:1.25
    name: web
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

### ngnix label version 
```
apiVersion: v1
kind: Pod
metadata:
  labels:
   app: web
   type: frontend
   name: nginx
   release: stable
  name: pod-nginx-label
spec:
  containers:
  - image: nginx:1.25
    name: nginx-container
```

### nginx node label version 
- ssd 가 달린 node 에 설치 
```
apiVersion: v1
kind: Pod
metadata:
  name: testpod
spec:
  containers:
  - image: nginx:1.25
    name: nginx
    ports:
    - containerPort: 80
  nodeSelector:
    type: ssd
```

### nginx node label ( --dry-run=client -o yaml )
 - 자동 생성된 매니페스트 형태 yaml 
```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: test-deploy
  name: test-deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: test-deploy
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: test-deploy
    spec:
      containers:
      - image: nginx:1.25
        name: nginx
        ports:
        - containerPort: 80
      nodeSelector:
        type: ssd
```

### Resource Requests version 
```
apiVersion: v1
kind: Pod
metadata:
  name: pod-resource
spec:
  containers:
  - name: nginx-congainer
    image: nginx:1.25
    ports:
    - containerPort: 80
    resources:
      requests:
        cpu: 1
        memory: 250Mi
```


### Resource + limits 설정 version
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx-congainer
    image: nginx:1.25
    ports:
    - containerPort: 80
      protocol: TCP
    resources:
      requests:
        cpu: 100m
        memory: 250Mi
      limits:
        cpu: 500m
        memory: 500Mi
```

### 연습 ( label , nodeSelector ..)
```

apiVersion: v1
kind: Pod
metadata:
  name: webui
  labels:
    app: web
    tier: frontend
    release: stable
spec:
  containers:
  - name: web
    image: hongjeongho/nginx:1.25
    ports:
    - containerPort: 80

    resources:
      requests:
        cpu: 500m
        memory: 700Mi

  nodeSelector:
    disktype: "ssd"
```

###  자동 생성된 매니페스트 형태 version 2
- kubectl run webserver --image=nginx:stable --port=80 --dry-run=client -o yaml
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: webserver
  name: webserver
spec:
  containers:
  - image: nginx:stable
    name: webserver
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

