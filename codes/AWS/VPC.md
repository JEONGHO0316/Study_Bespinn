AWS - VPC 생성 후 삭제 

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateVpc",
        "ec2:DeleteVpc"
      ],
      "Resource": "*"
    }
  ]
}
``` 

자바&깃 설치와 버전확인
```
sudo yum install java-17-amazon-corretto-devel -y

sudo dnf install git -y

java -version

git --version
```