
### sts 연습 
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: sf-nginx
spec:
  replicas: 3
  serviceName: sf-nginx-service
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
        image: nginx:1.14
        ports:
        - containerPort: 80
        volumeMounts:
        - name: html
          mountPath: /usr/share/nginx/html

  volumeClaimTemplates:
  - metadata:
      name: html
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 1Gi
      storageClassName: local-path
```

### Headless 서비스 
```
apiVersion: v1
kind: Service
metadata:
  name: sf-nginx-service
spec:
  clusterIP: None
  selector:
    app: webui
  ports:
  - port: 80
    name: web
```