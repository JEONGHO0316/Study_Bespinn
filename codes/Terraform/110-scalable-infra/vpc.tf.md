### Version 설정 및 기본 VPC 구성 
```
# Versions.tf
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

### VPC ### 
# VPC 생성
resource "aws_vpc" "scalble-vpc" {
  cidr_block = "10.0.0.0/16"

  #DNS 설정 1. vpc 안에서 도메인 질의 가능 / 2. 인스턴스에 DNS 붙여줌 
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "scalble-vpc"
  }
}

### IGW ### 
# IGW 생성
resource "aws_internet_gateway" "scalble-gw" {
  vpc_id = aws_vpc.scalble-vpc.id

  tags = {
    Name = "scalble-gw"
  }
}

### Public Subnet ###
# Public Subnet 생성
resource "aws_subnet" "scalble-pub-a" {
  vpc_id                  = aws_vpc.scalble-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "scalble-subnet-public-A"
  }
}

# Public Subnet 생성
resource "aws_subnet" "scalble-pub-c" {
  vpc_id                  = aws_vpc.scalble-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "scalble-subnet-public-C"
  }
}

# Public RT 생성 
resource "aws_route_table" "scalble-rt" {
  vpc_id = aws_vpc.scalble-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.scalble-gw.id
  }

  tags = {
    Name = "scalble-public-rt"
  }
}

# Public RT 서브넷 연결
resource "aws_route_table_association" "scalble-pub-rt-a" {
  subnet_id      = aws_subnet.scalble-pub-a.id
  route_table_id = aws_route_table.scalble-rt.id
}

# Public RT 서브넷 연결
resource "aws_route_table_association" "scalble-pub-rt-c" {
  subnet_id      = aws_subnet.scalble-pub-c.id
  route_table_id = aws_route_table.scalble-rt.id
}

### Private ### 
# Private Subnet 생성
resource "aws_subnet" "scalble-pri-a" {
  vpc_id                  = aws_vpc.scalble-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = false
  tags = {
    Name = "scalble-subnet-private-A"
  }
}

# Private Subnet 생성
resource "aws_subnet" "scalble-pri-c" {
  vpc_id                  = aws_vpc.scalble-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = false
  tags = {
    Name = "scalble-subnet-private-C"
  }
}

# Private RT 1 생성 
resource "aws_route_table" "scalble-rt-pri1" {
  vpc_id = aws_vpc.scalble-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.scalble-nat-a.id
  }

  tags = {
    Name = "scalble-private-rt1"
  }
}

# Private RT 2 생성 
resource "aws_route_table" "scalble-rt-pri2" {
  vpc_id = aws_vpc.scalble-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.scalble-nat-c.id
  }

  tags = {
    Name = "scalble-private-rt2"
  }
}

# Private RT 서브넷 연결
resource "aws_route_table_association" "scalble-pri-rt-a" {
  subnet_id      = aws_subnet.scalble-pri-a.id
  route_table_id = aws_route_table.scalble-rt-pri1.id
}

resource "aws_route_table_association" "scalble-pri-rt-c" {
  subnet_id      = aws_subnet.scalble-pri-c.id
  route_table_id = aws_route_table.scalble-rt-pri2.id
}

### NAT 생성 ###
resource "aws_eip" "eip-a" {
  domain = "vpc"
  tags = {
    Name = "scalble-nat-eip-a"
  }
}

resource "aws_nat_gateway" "scalble-nat-a" {
  allocation_id = aws_eip.eip-a.id
  subnet_id     = aws_subnet.scalble-pub-a.id

  tags = {
    Name = "scalble-NAT-a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.scalble-gw]
}

### NAT 생성 ###
resource "aws_eip" "eip-c" {
  domain = "vpc"
  tags = {
    Name = "scalble-nat-eip-c"
  }
}

resource "aws_nat_gateway" "scalble-nat-c" {
  allocation_id = aws_eip.eip-c.id
  subnet_id     = aws_subnet.scalble-pub-c.id

  tags = {
    Name = "scalble-NAT-c"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.scalble-gw]
}
```