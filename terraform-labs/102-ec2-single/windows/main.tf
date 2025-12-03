provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "windows" {
  ami           = "ami-045293d19d738a663"
  instance_type = "t3.small"
  tags = {
    Name = "tf-windows-web"
  }
}