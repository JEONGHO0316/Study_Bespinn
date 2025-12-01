```
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

```