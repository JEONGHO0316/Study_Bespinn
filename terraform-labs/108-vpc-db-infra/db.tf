resource "aws_security_group" "rds" {
  vpc_id      = aws_vpc.tf-vpc.id
  name        = var.rds_security_group_name # "allow_3306"
  description = "Allow mysql inbound traffic"

  ingress {
    description = "Mysql  from VPC"
    from_port   = 3306 # 80
    to_port     = 3306 # 80
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
    Name = var.rds_security_group_name
  }

  lifecycle {
    create_before_destroy = true
  }

}