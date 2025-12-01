
### Ubuntu AMI 사용 ASG + ALB 웹서버 배포 
```
terraform {
  required_version = ">=1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

# DataResource 

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "ubuntu_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.*"]
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
    values = ["x86_64"]
  }
}

# Resource 
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.module}/keys/mykey.pub")
}

resource "aws_launch_template" "web" {
  name = "web"

  # data소스를 통해 가져온  최신 ubuntu의 이미지 사용 
  image_id               = data.aws_ami.ubuntu_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]

  monitoring {
    enabled = true
  }

  key_name = aws_key_pair.mykey.key_name
  user_data = base64encode(
    templatefile("${path.module}/userdata.tftpl", {
      port_number = "${var.server_port}"
    })
  )

}

resource "aws_autoscaling_group" "web-asg" {
  name = "web-asg-group"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4
  
  // asg group 을 전파할 서브넷 위치 
  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"
  health_check_grace_period = 60
  default_cooldown = 60 

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  tag {
    key                 = "Name"
    value               = "tf-asg-ubuntu"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      // 사용하고있는 최소 갯수 , 우리는 2개로 시작했으니까 1개 
      min_healthy_percentage = 50
      instance_warmup        = 60
    }
  }

}


# 보안그룹 생성 ( web 인바운드 )
resource "aws_security_group" "web" {
  name        = var.web_security_group_name
  description = "Allow_http_inbound"
  ingress {
    description = "http from vpc"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id]
    #cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "http from vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.web_security_group_name
  }

  lifecycle {
    create_before_destroy = true
  }

}

# lb sg 생성
resource "aws_security_group" "alb" {
  name        = var.alb_security_group_name
  description = "Allow_http_inbound_traffic"

  ingress {
    description = "http from vpc"
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.alb_security_group_name
  }

  lifecycle {
    create_before_destroy = true
  }

}

# alb 생성 
resource "aws_lb" "alb" {
  name               = var.alb_name
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]
}

# alb 리스너 정의 
resource "aws_lb_listener" "http" {
  # 필수 작성 해야할 2가지 
  load_balancer_arn = aws_lb.alb.arn
  default_action { # By default, return a simple 404 page
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404:page not found \n"
      status_code  = 404
    }
  }

  port     = var.server_port
  protocol = "HTTP"
}

# alb 타겟 그룹 생성
resource "aws_lb_target_group" "asg" {
  # name     = var.alb_name
  target_type          = "instance"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
  deregistration_delay = 60 # ( 기본값 300 초 )

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }

}


# alb 리스너 규칙 생성 하여 연결
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }

}

# alb sg input 함수 생성 
variable "alb_security_group_name" {
  description = "The name of the security group"
  type        = string
  # default     = "allow_http_alb"
}

# alb lb 함수 생성
variable "alb_name" {
  description = "The name of the alb"
  type        = string
  default     = "ex-alb"
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  # default     = 80
}

variable "web_security_group_name" {
  description = "The name of the security group"
  type        = string
  # default     = "allow_http"
}

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
  # default     = "ami-0c1508b5372d244d7" # Amazon Linux 2023 (ap-northeast-2)
}

variable "instance_type" {
  description = "EC2 instance type for the web server."
  type        = string
  # default     = "t3.micro"
}

output "alb_dns_name" {
  description = "The domain name of the load balancer"
  value       = aws_lb.alb.dns_name
}

```

### Amazon linux ASG + ALB 웹서버 배포  AMI 는 Coalesce 사용 
```
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

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.module}/keys/mykey.pub")
}

resource "aws_launch_template" "web" {
  name = "lt-web"
  # ami-0c1508b5372d244d7 or ami-04fcc2023d6e37430 
  image_id               = coalesce(var.image_id, data.aws_ami.amzonlinux.id)
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]


  monitoring {
    enabled = true
  }

  key_name = aws_key_pair.mykey.key_name
  user_data = base64encode(templatefile("${path.module}/userdata.tftpl", {
      #port_number = var.server_port
      port_number = var.server_port
    })
  )


}

resource "aws_autoscaling_group" "web" {
  name = "asg-web"

  // 최소 최댓값 
  min_size = 2
  max_size = 4

  // 시작값 
  desired_capacity = 4

  vpc_zone_identifier = data.aws_subnets.default.ids

  # 새로 생성된 EC2 인스턴스 들을 방금 생성한 대상그룹에 포함 해야 함으로
  // 추가  
  target_group_arns         = [aws_lb_target_group.asg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 60
  default_cooldown          = 60
  launch_template {
    id = aws_launch_template.web.id
    # version = "$Latest" # 지정안하면 "$Default " - > 이 값
    version = aws_launch_template.web.latest_version
  }

  tag {
    key                 = "Name"
    value               = "tf-asg-web"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      // 사용하고있는 최소 갯수 , 우리는 2개로 시작했으니까 1개 
      min_healthy_percentage = 50
      instance_warmup        = 60
    }
  }


}

resource "aws_security_group" "web" {
  name        = var.web_security_group_name # "allow_http"
  description = "Allow HTTP inbound traffic"

  ingress {
    description = "HTTP from VPC"
    from_port   = var.server_port # 80
    to_port     = var.server_port # 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id]
     #cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.web_security_group_name
  }

  // 보안 그룹 만들때는 먼저 만들고 교체해라 라는 명령어 
  // lifecycle 
  lifecycle {
    create_before_destroy = true
  }
}

# ALB 보안그룹 
resource "aws_security_group" "alb" {
  name        = var.Alb_security_group_name
  description = "Allow Http inbound traffic "

  ingress {
    description = "HTTP from VPC"
    from_port   =  80
    to_port     =  80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.Alb_security_group_name
  }
  // 보안 그룹 만들때는 먼저 만들고 교체해라 라는 명령어 
  // lifecycle 
  lifecycle {
    create_before_destroy = true
  }

}

# ALB 생성 
resource "aws_lb" "alb" {
  name               = var.alb_name
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]
}

# 리스너 생성 
resource "aws_lb_listener" "http" {
  # 필수로 적어줘야하는 2가지 arn , default_action 
  load_balancer_arn = aws_lb.alb.arn
  # By default, return a simple 404 page 
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page not found\n"
      status_code  = 404
    }
  }

  port     =  80
  protocol = "HTTP"
}

# 대상 그룹 생성 
resource "aws_lb_target_group" "asg" {
  #name                 = "tg-web"
  target_type          = "instance"
  port                 = var.server_port
  protocol             = "HTTP"
  vpc_id               = data.aws_vpc.default.id
  deregistration_delay = 60 # ( 기본값 300 초 )


  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }

}

#리스너 규칙 생성 및 연결
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }

}

# ALB 이름 변수 
variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  # default     = 80
}

# 새로 만드는 LB 보안그룹과 차별화 위해 이름 변경 
variable "web_security_group_name" {
  description = "The name of the security ec2 group"
  type        = string
  # default     = "allow_http"
}

# 새로 만드는 LB 보안그룹
variable "Alb_security_group_name" {
  description = "The name of the security alb group"
  type        = string
  # default     = "allow_http"
}

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
  # default     = "ami-0c1508b5372d244d7" # Amazon Linux 2023 (ap-northeast-2)
}

variable "instance_type" {
  description = "EC2 instance type for the web server."
  type        = string
  # default     = "t3.micro"
}

# ALB DNS 출력 
output "alb_dns_name" {
  description = "The Domain name of the load balancer"
  value       = aws_lb.alb.dns_name
}
```