provider "aws" {
  region = "ap-northeast-2" # Asia Pacific (seoul) region
}

resource "aws_instance" "web" {
  ami           = "ami-0aa02302a11ea5190" # AMAZON Linux 2023 
  instance_type = "t3.micro"
  tags = {
    Name = "tf-web"
  }
}

