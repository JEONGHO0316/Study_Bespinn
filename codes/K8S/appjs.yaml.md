
### appjs ( my repo )

```
apiVersion: v1
kind: Pod
metadata:
  labels:
   app: web
   release: stable
  name: pod-appjs-label
spec:
  containers:
  - image: hongjeongho/appjs
    name: pod-appjs
    ports:
    - containerPort: 8080
```

### Annotations version
```
apiVersion: v1
kind: Pod
metadata:
  name: pod-appjs-an
  annotations:
    description: "Simple appjs-based Web Server"
    builder: "jeong ho ( kjll290551@gmail.com)"
    buildDate: "20251104"
    imageregistry: "http://hub.docker.com/"
spec:
  containers:
  - name: pod-appjs
    image: hongjeongho/appjs
    ports:
    - containerPort: 8080
```

### myrepo appjs 연습 
```
apiVersion: v1
kind: Pod
metadata:
  name: pod-other
  labels:
    app: web
spec:
  containers:
  - name: appjh-container
    image: hongjeongho/appjs
    ports:
    - containerPort: 80

```

