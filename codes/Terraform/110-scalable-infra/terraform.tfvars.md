

### 변수를 세팅할 파일 

```
image_id                = "ami-0ebbd41421b6a0ac6" #"ami-0c1508b5372d244d7"
instance_type           = "t3.micro"
server_port             = 80
web_security_group_name = "WEB-SG"

# LB 변수 설정 
alb_security_group_name = "ALB-SG"
alb_name                = "ex-alb"

# DB 변수 설정 
rds_security_group_name = "RDS-SG"
db_id = "admin"
db_passwd = ""
db_endpoint = "sscalble-db.cq0vkrx9gj0x.ap-northeast-2.rds.amazonaws.com"
db_name = "scalbledb"
```

