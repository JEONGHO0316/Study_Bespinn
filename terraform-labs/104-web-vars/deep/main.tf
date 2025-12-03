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

/*
data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.tftpl")}"
  vars = {
    port_number = "${var.server_port}"
  }
}
*/

resource "aws_instance" "web" {
  ami = var.image_id          # AMAZON Linux 2023 ( ap-northeast-2 )
  instance_type = var.instance_type

  # vpc_security_group_ids = ["sg-04cede5bb5e23511b"] 
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name = "tfkey"
  user_data_replace_on_change = true
  //user_data = file("${path.module}/userdata.sh")

  // template_file 
  //user_data = data.template_file.user_data.rendered 
  
  // templatefile 
  user_data = templatefile("${path.module}/userdata.tftpl", { 
    port_number = "${var.server_port}"
  })
  tags = {
    Name = "tf-web"
  }
}

# 보안그룹 생성 ( 인바운드 )
resource "aws_security_group" "web" {
  name        = var.security_group_name
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

}

# 변수 추가 
variable "server_port" {
  description = "The Port the server will use for HTTP requests"
  type        = number
  default = 81
}

variable "security_group_name" {
  description = "The Name of the security group"
  type        = string
  default     = "Allow_http"
}

variable "image_id" {
  description = "The Name of the id"
  default = "ami-0c1508b5372d244d7"
}

variable "instance_type" {
  description = "The Name of the type"
  type = string
  default = "t3.micro"
}

output "public_ip" {
  description = "Public IP of the web"
  value = "${aws_instance.web.public_ip}:${var.server_port}"
}

output "private_ip" {
  description = "Private IP of the web"
  value = aws_instance.web.private_ip
}