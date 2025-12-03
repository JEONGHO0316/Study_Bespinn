provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-0a71e3eb8b23101ed"
  instance_type = "t3.micro"
  tags = {
    Name = "tf-ubunut-web"
  }
}