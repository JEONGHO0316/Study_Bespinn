### Deployment 연습 

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deploy-naginx
spec:
  replicas: 2
  selector:
   matchLabels:
     app: web
   matchExpressions:
     - {key: version, operator: In, values: ["1.14", "1.15"]}
  template:
    metadata:
     name: nginx-pod
     labels:
       app: web
       version: "1.14"
    spec:
      containers:
      - name: nginx-container
        image: nginx:1.14
        ports:
        - containerPort: 80
```

### Deployment 실습 
```

apiVersion: apps/v1
kind: Deployment
metadata:
  name: dep-mainui
  annotations:
    kubernetes.io/change-cause: version 2.4
spec:
  replicas: 2
  selector:
   matchLabels:
     name: apache
     app: main
     rel: stable
   matchExpressions:
     - {key: version, operator: In, values: ["2.2", "2.4"]}
  template:
    metadata:
     name: nginx-pod
     labels:
       name: apache
       app: main
       rel: stable
       version: "2.4"
    spec:
      containers:
      - name: apache-cont
        image: httpd:2.4
        ports:
        - containerPort: 80
```
