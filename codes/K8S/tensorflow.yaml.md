### GPU 있는 NODESELECT 연습 
```
apiVersion: v1
kind: Pod
metadata:
  name: tensorflow-gpu
spec:
  containers:
  - name: tensorflow
    image: tensorflow/tensorflow:nightly-jupyter
    ports:
    - containerPort: 8888
      protocol: TCP
  nodeSelector:
    gpu: "true"

```