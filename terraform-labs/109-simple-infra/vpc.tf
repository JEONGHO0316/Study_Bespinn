# VPC 생성
resource "aws_vpc" "simple-vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "simple-vpc"
  }
}

# IGW 생성
resource "aws_internet_gateway" "simple-gw" {
  vpc_id = aws_vpc.simple-vpc.id

  tags = {
    Name = "simple-gw"
  }
}

# Public Subnet 생성
resource "aws_subnet" "simple-pub-a" {
  vpc_id                  = aws_vpc.simple-vpc.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "simple-subnet-public-A"
  }
}

# Public Subnet 생성
resource "aws_subnet" "simple-pub-c" {
  vpc_id                  = aws_vpc.simple-vpc.id
  cidr_block              = "192.168.2.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "simple-subnet-public-C"
  }
}

# Public RT 생성 
resource "aws_route_table" "simple-rt" {
  vpc_id = aws_vpc.simple-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.simple-gw.id
  }

  tags = {
    Name = "simple-public-rt"
  }
}

# Public RT 서브넷 연결
resource "aws_route_table_association" "simple-asso-a" {
  subnet_id      = aws_subnet.simple-pub-a.id
  route_table_id = aws_route_table.simple-rt.id
}

resource "aws_route_table_association" "simple-asso-c" {
  subnet_id      = aws_subnet.simple-pub-c.id
  route_table_id = aws_route_table.simple-rt.id
}

### Private ### 

# Private Subnet 생성
resource "aws_subnet" "simple-pri-a" {
  vpc_id                  = aws_vpc.simple-vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "simple-subnet-private-A"
  }
}

resource "aws_subnet" "simple-pri-c" {
  vpc_id                  = aws_vpc.simple-vpc.id
  cidr_block              = "192.168.3.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "simple-subnet-private-C"
  }
}

# Private RT 생성 
resource "aws_route_table" "simple-rt-pri1" {
  vpc_id = aws_vpc.simple-vpc.id

  tags = {
    Name = "simple-private-rt1"
  }
}

resource "aws_route_table" "simple-rt-pri2" {
  vpc_id = aws_vpc.simple-vpc.id

  tags = {
    Name = "simple-private-rt2"
  }
}

# Private RT 서브넷 연결
resource "aws_route_table_association" "simple-asso-pri-a" {
  subnet_id      = aws_subnet.simple-pri-a.id
  route_table_id = aws_route_table.simple-rt-pri1.id
}

resource "aws_route_table_association" "simple-asso-pri-c" {
  subnet_id      = aws_subnet.simple-pri-c.id
  route_table_id = aws_route_table.simple-rt-pri2.id
}