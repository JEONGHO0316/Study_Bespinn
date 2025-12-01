
### ASG Amazon linux ( 최신버전 AMI 사용 ) 웹 서버 배포 
```
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = "ap-northeast-2" # Asia Pacific (Seoul) region
}

/*
resource "aws_instance" "web" {
  ami                         = var.image_id                # "ami-0c1508b5372d244d7" # Amazon Linux 2023 (ap-northeast-2)
  instance_type               = var.instance_type           # "t3.micro"
  vpc_security_group_ids      = [aws_security_group.web.id] # "sg-0c6899c025da3a0f6"
  user_data_replace_on_change = true
  key_name                    = "tfkey"

  user_data = <<-EOF
    #!/bin/bash
    yum -y install httpd
    sed -i 's/Listen 80/Listen ${var.server_port}/' /etc/httpd/conf/httpd.conf
    systemctl enable httpd
    systemctl restart httpd
    echo '<html><h1>Hello From Your Linux Web Server running on port ${var.server_port}</h1></html>' > /var/www/html/index.html
    EOF

  tags = {
    Name = "tf-web"
  }
}
*/

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

}

data "aws_ami" "amzonlinux" {
  most_recent = true
  owners      = ["amazon"]

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

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.module}/keys/mykey.pub")
}

resource "aws_launch_template" "web" {
  name = "lt-web"
  # ami-0c1508b5372d244d7 or ami-04fcc2023d6e37430 
  image_id               = coalesce(var.image_id, data.aws_ami.amzonlinux.id)
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]


  monitoring {
    enabled = true
  }

  key_name = aws_key_pair.mykey.key_name
  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    yum -y install httpd
    sed -i 's/Listen 80/Listen ${var.server_port}/' /etc/httpd/conf/httpd.conf
    systemctl enable httpd
    systemctl restart httpd
    echo '<html><h1>Hello From Your Linux Web Server running on port ${var.server_port}</h1></html>' > /var/www/html/index.html
    EOF
  )


}

resource "aws_autoscaling_group" "web" {
  name = "asg-web"

  // 최소 최댓값 
  min_size = 2
  max_size = 4

  // 시작값 
  desired_capacity = 2

  vpc_zone_identifier = data.aws_subnets.default.ids
  launch_template {
    id = aws_launch_template.web.id
    # version = "$Latest" # 지정안하면 "$Default " - > 이 값
    version = aws_launch_template.web.latest_version
  }

  tag {
    key                 = "Name"
    value               = "tf-asg-web"
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

resource "aws_security_group" "web" {
  name        = var.security_group_name # "allow_http"
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
    #cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // 보안 그룹 만들때는 먼저 만들고 교체해라 라는 명령어 
  // lifecycle 
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


/*
output "public_ip" {
  description = "The public IP address of the web server"
  value       = "${aws_instance.web.public_ip}:${var.server_port}"
}

output "instance_ip" {
  description = "Private IP address of the EC2 instance"
  value       = "${aws_instance.web.private_ip}:${var.server_port}"
}

*/
```