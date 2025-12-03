# 키페어 구성 
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.module}/keys/mykey.pub")
}

# 최신 이미지 사용 
data "aws_ami" "slmple-ami" {
  most_recent = true
  name_regex  = "^al"
  owners      = ["amazon"]

  filter {
    name   = "name"
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
    values = ["x86_64"]
  }
}

# web 보안그룹 생성 
resource "aws_security_group" "simple-sg" {
  name        = var.web_security_group_name
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.simple-vpc.id
  ingress {
    description = "HTTP from VPC"
    from_port   = var.server_port # 80
    to_port     = var.server_port # 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbount"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WEB-SG"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# instance 생성 
resource "aws_instance" "simple-instance" {
  ami           = coalesce(var.image_id , data.aws_ami.slmple-ami.id)
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.simple-sg.id]
  user_data_replace_on_change = true
  subnet_id = aws_subnet.simple-pub-c.id
  key_name = "mykey"
  user_data_base64 = base64encode(file("${path.module}/userdata.tftpl"))
    
  tags = {
    Name = "simple-web"
  }
}

