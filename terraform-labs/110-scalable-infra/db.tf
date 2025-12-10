# RDS 보안그룹 생성 
resource "aws_security_group" "scalble-db-sg" {
  name        = var.rds_security_group_name
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.scalble-vpc.id
  ingress {
    description = "HTTP from VPC"
    from_port   = 3306
    to_port     = 3306
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
    Name = "RDS-SG"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# RDS SUBNET GROUP 생성
resource "aws_db_subnet_group" "scalble-db" {
  name = "scalble-db-subnet-group"

  subnet_ids = [aws_subnet.scalble-pri-a.id, aws_subnet.scalble-pri-c.id]

  tags = {
    Name = "RDS subnet group"
  }
}

# RDS Instance 생성 
resource "aws_db_instance" "scalbledb" {
  identifier        = "sscalble-db"
  allocated_storage = 20
  db_name           = "scalbledb"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  username          = "admin"
  password          = ""
  
  skip_final_snapshot = true
  
  # parameter_group_name = "default.mysql8.0"
  multi_az = true
  db_subnet_group_name   = aws_db_subnet_group.scalble-db.name
  
  vpc_security_group_ids = [aws_security_group.scalble-db-sg.id]

}

