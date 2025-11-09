```
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: eks-project-cluster
  region: ap-northeast-2
  version: "1.33"
  tags:
    env: production
    project: eks-project

iam:
  withOIDC: true

vpc:
  id: vpc-0a51f6dd5019d96ff
  subnets:
    private:
      ap-northeast-2a:
        id: subnet-0282ec7bc34d8d7a9
      ap-northeast-2b:
        id: subnet-05049ad8134f28c97
    public:
      ap-northeast-2a:
        id: subnet-077dd1c8ffe5dface
      ap-northeast-2b:
        id: subnet-0151a473a7cc3107f
  clusterEndpoints:
    privateAccess: true
    publicAccess: true

managedNodeGroups:
  - name: default
    desiredCapacity: 2
    minSize: 2
    maxSize: 4
    instanceType: t3.medium
    privateNetworking: true
    labels:
      role: worker

addons:
  - name: vpc-cni
    version: latest
    resolveConflicts: overwrite
  - name: coredns
    version: latest
  - name: kube-proxy
    version: latest
```