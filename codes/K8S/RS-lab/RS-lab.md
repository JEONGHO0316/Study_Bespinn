
### ReplicaSet 연습
```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: rs-nginx
spec:
  replicas: 3
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
       version: "1.15"
    spec:
      containers:
      - name: nginx-container
        image: nginx:1.14
```

### ReplicaSet lab
```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: rs-apache
spec:
  replicas: 2
  selector:
   matchLabels:
     name: apache
     app: main
     rel: stable
   matchExpressions:
     - {key: version, operator: In, values: ["2.2","2.4"]}
  template:
    metadata:
     name: apache-pod
     labels:
       name: apache
       app: main
       rel: stable
       version: "2.2"
    spec:
      containers:
      - name: apache-container
        image: httpd:2.2
```