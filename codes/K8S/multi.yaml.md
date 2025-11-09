
### 하나의 Pod 안에서 2개의 컨테이너 실행 
- 기본은 Ngnix (웹서버)
- 2번째 rocky linux 에서 무한 루프 
```
apiVersion: v1
kind: Pod
metadata:
  name: multiple-pod
spec:
 containers:
 - name: nginx-container
   image : nginx:1.25
   ports:
   - containerPort: 80
 - name: rocky-container
   image: rockylinux:9
   command: ["/bin/bash","-c","while true; do sleep 10; echo heel; done"]
     #command: ["/bin/bash","-c","sleep infinity"]
```

실행 명령어 
```
kubectl apply -f multiple-pod.yaml
kubectl get pods
kubectl exec -it multiple-pod -c rocky-container -- bash
```