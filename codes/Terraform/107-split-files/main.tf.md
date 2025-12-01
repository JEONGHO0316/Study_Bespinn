```
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

  // 인스턴스를 생성할 서브넷 지정 
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
    description     = "HTTP from VPC"
    from_port       = var.server_port # 80
    to_port         = var.server_port # 80
    protocol        = "tcp"
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
    from_port   = 80
    to_port     = 80
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

  port     = 80
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




```