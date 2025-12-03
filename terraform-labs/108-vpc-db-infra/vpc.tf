resource "aws_vpc" "tf-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "tf-vpc"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-igw"
  }
}

resource "aws_subnet" "pub_a" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-subnet-public1-ap-northeast-2a"
  }
}

resource "aws_subnet" "pub_c" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-subnet-public2-ap-northeast-2c"
  }
}


# private subnet 
resource "aws_subnet" "pri_a" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  #map_public_ip_on_launch = true
  tags = {
    Name = "tf-subnet-private1-ap-northeast-2a"
  }
}

resource "aws_subnet" "pri_c" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"
  #map_public_ip_on_launch = true
  tags = {
    Name = "tf-subnet-private2-ap-northeast-2c"
  }
}

resource "aws_route_table" "pub" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }

  tags = {
    Name = "tf-rtb-public"
  }
}


resource "aws_route_table" "pri_a" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "tf-rtb-private1"
  }
}


resource "aws_route_table" "pri_c" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "tf-rtb-private2"
  }
}

// public
# RT Table 연결 a
resource "aws_route_table_association" "pub_a" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.pub.id
}
# RT Table 연결 c 
resource "aws_route_table_association" "pub_c" {
  subnet_id      = aws_subnet.pub_c.id
  route_table_id = aws_route_table.pub.id
}

// private 
// RT table 연결 
# RT Table 연결 a
resource "aws_route_table_association" "pri_a" {
  subnet_id      = aws_subnet.pri_a.id
  route_table_id = aws_route_table.pri_a.id
}

# RT Table 연결 c 
resource "aws_route_table_association" "pri_c" {
  subnet_id      = aws_subnet.pri_c.id
  route_table_id = aws_route_table.pri_c.id
}

# Nat gateway 가 사용 할 EIP 
resource "aws_eip" "pub_a" {
  domain = "vpc"
  tags = {
    Name = "tf-eip-apne2a"
  }
}

# Nat gateway 생성 
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.pub_a.id
  subnet_id     = aws_subnet.pub_a.id

  tags = {
    Name = "tf-NAT-pub1-apne2a"
  }

  depends_on = [aws_internet_gateway.tf-igw]
}