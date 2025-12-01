
### amazon linux 단일 instance 배포 
```
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
```

### windows server 단일 instance 배포 
```
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
```

### ubuntu server 단일 instance 배포 
```
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
```