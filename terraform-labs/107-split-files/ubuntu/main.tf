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

  target_group_arns         = [aws_lb_target_group.asg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 60
  default_cooldown          = 60

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
    description     = "http from vpc"
    from_port       = var.server_port
    to_port         = var.server_port
    protocol        = "tcp"
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




