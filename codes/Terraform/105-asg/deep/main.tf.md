### Ubuntu 용 Asg 웹 서버 배포 
```
terraform {
  required_version = ">=1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

# DataResource 

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "ubuntu_linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.*"]    
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

# Resource 
resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = file("${path.module}/keys/mykey.pub")
}

resource "aws_launch_template" "web" {
  name          = "web"
  
                  # data소스를 통해 가져온  최신 ubuntu의 이미지 사용 
  image_id      = data.aws_ami.ubuntu_linux.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]

  monitoring {
    enabled = true
  }
  
  key_name = aws_key_pair.mykey.key_name
  user_data = base64encode(
    templatefile("${path.module}/userdata.tftpl", {
      port_number = "${var.server_port}"
    })
  )

}

resource "aws_autoscaling_group" "web-asg" {
  name = "web-asg-group"

  desired_capacity = 2

  min_size = 2
  max_size = 4

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }
  
  vpc_zone_identifier = data.aws_subnets.default.ids

  tag {
    key                 = "Name"
    value               = "tf-asg-ubuntu"
    propagate_at_launch = true
  }

   instance_refresh {
    strategy = "Rolling"
    preferences {
      // 사용하고있는 최소 갯수 , 우리는 2개로 시작했으니까 1개 
      min_healthy_percentage = 50
      instance_warmup        = 60
    }
  }

}


# 보안그룹 생성 ( 인바운드 )
resource "aws_security_group" "web" {
  name        =  var.security_group_name
  description = "Allow_http_inbound"
  ingress {
    description = "http from vpc"
    from_port   = var.server_port
    to_port     = var.server_port
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
    description = "http from vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-asg"
  } 

  lifecycle {
    create_before_destroy = true
  }

}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  # default     = 80
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  # default     = "allow_http"
}

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
  # default     = "ami-0c1508b5372d244d7" # Amazon Linux 2023 (ap-northeast-2)
}

variable "instance_type" {
  description = "EC2 instance type for the web server."
  type        = string
  # default     = "t3.micro"
}

```