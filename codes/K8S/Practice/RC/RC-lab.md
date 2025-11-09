### ReplicationController 연습
```
apiVersion: v1
kind: ReplicationController
metadata:
  name: rc-nginx
spec:
  replicas: 3
  selector:
   app: web
  template:
    metadata:
     name: nginx-pod
     labels:
       app: web
    spec:
      containers:
      - name: nginx-container
        image: nginx:1.14
```
### ReplicationController 실습 
```
apiVersion: v1
kind: ReplicationController
metadata:
  name: rc-mainui
spec:
  replicas: 2
  selector:
    name: apache
    app: main
    rel: stable
  template:
    metadata:
    # name: apache-pod
      labels:
       name: apache
       app: main
       rel: stable
    spec:
      containers:
      - name: httpd-container
        image: httpd:2.2
        ports:
        - containerPort: 80
```