### DS 연습 
```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: ds-nginx
  annotations:
   kubernetes.io/change-cause: "Upgrade version nginx:1.15"
spec:
  selector:
   matchLabels:
     app: webui
  template:
    metadata:
     name: nginx-pod
     labels:
       app: webui
    spec:
      containers:
      - name: nginx-container
        image: nginx:1.15
        ports:
        - containerPort: 80
```
### DS 실습 
```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: ds-mainui
  annotations:
   kubernetes.io/change-cause: "version http:2.4"
spec:
  selector:
   matchLabels:
    app: web
  template:
    metadata:
     name: nginx-pod
     labels:
       app: web
    spec:
      containers:
      - name: web-container
        image: httpd:2.4
      resources:
       requests:
         cpu: 500m

      nodeSelector:
        disktype: "ssd"
```