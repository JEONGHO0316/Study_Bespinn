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