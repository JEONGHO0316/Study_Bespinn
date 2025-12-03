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

resource "aws_instance" "web" {
  ami           = "ami-0c1508b5372d244d7" # AMAZON Linux 2023 ( ap-northeast-2 )
  instance_type = "t3.micro"

  # vpc_security_group_ids = ["sg-04cede5bb5e23511b"] 
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
    #!/bin/bash
    yum -y install httpd 
    systemctl enable httpd 
    systemctl restart httpd 
    echo '<html><h1>Hello From My Linux Web Server!</h1></html>' > /var/www/html/index.html
    EOF

  tags = {
    Name = "tf-web"
  }
}

# 보안그룹 생성 ( 인바운드 )
resource "aws_security_group" "web" {
  name        = "Allow_http"
  description = "Aloow_http_inbound"
  ingress {
    description = "http from vpc"
    from_port   = 80
    to_port     = 80
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

}

