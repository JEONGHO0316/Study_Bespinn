### DB를 포함한 인스턴스 구성 
```
# 키페어 구성 
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.module}/keys/mykey.pub")

}


data "aws_ami" "amzonlinux" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^al"
  // filter 가 많으면 시간이 많이 걸린다 
  filter {
    name = "name"
    # al2023-ami-2023.9.20251110.1-kernel-6.1-x86_64
    values = ["al2023-ami-2023.*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"] // "arm 64 "
  }
}

resource "aws_security_group" "web" {
  # 직접만든 VPC 에 생성 하기 위해 작성
  # default vpc 사용 할땐 사용 X 
  #  왜냐하면 적지 않으면 기본으로 default vpc에 생성 
  vpc_id      = aws_vpc.tf-vpc.id
  name        = var.web_security_group_name # "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP from VPC"
    from_port   = var.server_port # 80
    to_port     = var.server_port # 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # my ip  1.223.214.165/32


  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.web_security_group_name
  }

  // 보안 그룹 만들때는 먼저 만들고 교체해라 라는 명령어 
  // lifecycle 
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "web_pub" {
  ami                    = coalesce(var.image_id, data.aws_ami.amzonlinux.id) # "ami-0c1508b5372d244d7" # Amazon Linux 2023 (ap-northeast-2)
  instance_type          = var.instance_type                                  # "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]                        # "sg-0c6899c025da3a0f6"
  subnet_id              = aws_subnet.pub_c.id

  user_data_replace_on_change = true
  key_name                    = aws_key_pair.mykey.key_name
  monitoring                  = true

  user_data = templatefile("${path.module}/userdata.tftpl", {
    port_number = var.server_port
    endpoint_number = aws_db_instance.tfdb.endpoint
  })

  tags = {
    Name = "tf-web-pub"
  }
}

resource "aws_instance" "web_pri" {
  ami                    = coalesce(var.image_id, data.aws_ami.amzonlinux.id) # "ami-0c1508b5372d244d7" # Amazon Linux 2023 (ap-northeast-2)
  instance_type          = var.instance_type                                  # "t3.micro"
  vpc_security_group_ids = [aws_security_group.web.id]                        # "sg-0c6899c025da3a0f6"
  subnet_id              = aws_subnet.pri_c.id
  key_name               = aws_key_pair.mykey.key_name
  monitoring             = true

  user_data_replace_on_change = true
  user_data = templatefile("${path.module}/userdata.tftpl", {
    port_number = var.server_port
    endpoint_number = aws_db_instance.tfdb.endpoint
  })
  tags = {
    Name = "tf-web-pri"
  }

  depends_on = [aws_nat_gateway.nat]
}

# DB 서브넷 그룹 
resource "aws_db_subnet_group" "tf-db" {
  name = "tf-db-subnet-group"
  # db의 서브넷은 기본 2 개 , 
  # 클러스터를 구성 한다면 3개 
  subnet_ids = [aws_subnet.pri_a.id, aws_subnet.pri_c.id]

  tags = {
    Name = "tf - My DB subnet group"
  }
}

resource "aws_db_instance" "tfdb" {
  identifier        = "tf-db"
  allocated_storage = 10
  db_name           = "tfdb"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  username          = "admin"
  password          = ""
  # parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  # multi_az = true
  db_subnet_group_name   = aws_db_subnet_group.tf-db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
}

```
