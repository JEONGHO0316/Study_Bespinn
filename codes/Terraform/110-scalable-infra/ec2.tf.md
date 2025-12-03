
### EC2 구성 

```
# 키페어 구성 
resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${path.module}/keys/mykey.pub")
}

# web 보안그룹 생성 
resource "aws_security_group" "scalble-web-sg" {
  name        = var.web_security_group_name
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.scalble-vpc.id
  ingress {
    description = "HTTP from VPC"
    from_port   = var.server_port # 80
    to_port     = var.server_port # 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbount"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WEB-SG"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# alb 보안그룹 생성 
resource "aws_security_group" "scalble-alb-sg" {
  name        = var.alb_security_group_name
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.scalble-vpc.id
  ingress {
    description = "HTTP from VPC"
    from_port   = var.server_port # 80
    to_port     = var.server_port # 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbount"
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

resource "aws_lb" "scalble-alb" {
  name               = var.alb_name
  load_balancer_type = "application"
  security_groups    = [aws_security_group.scalble-alb-sg.id]
  subnets            = [aws_subnet.scalble-pub-a.id , aws_subnet.scalble-pub-c.id]
}

#  alb 리스너 정의 
resource "aws_lb_listener" "http" {
  # 필수 작성 해야할 2가지 
  load_balancer_arn = aws_lb.scalble-alb.arn
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
resource "aws_lb_target_group" "scalble-asg" {
  # name     = var.alb_name
  target_type          = "instance"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.scalble-vpc.id
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
    target_group_arn = aws_lb_target_group.scalble-asg.arn
  }

}

# 시작 템플릿 생성 
resource "aws_launch_template" "scalble-template" {
  name          = "scalble-web"
  image_id      = var.image_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.scalble-web-sg.id]

  monitoring {
    enabled = true
  }

  key_name  = "mykey"

   user_data = base64encode(templatefile("${path.module}/userdata.tftpl",{
    id = var.db_id
    pw = var.db_passwd
    endpoint = var.db_endpoint 
    db_name = var.db_name
  }))

  depends_on = [ aws_db_instance.scalbledb]
}

resource "aws_autoscaling_group" "scalble-asg" {
  name = "scalble-asg-web"

  desired_capacity = 2

  min_size = 2
  max_size = 4
  
  force_delete = true

  vpc_zone_identifier = [aws_subnet.scalble-pri-a.id , aws_subnet.scalble-pri-c.id]
  #vpc_zone_identifier = [aws_subnet.scalble-pri-a.id, aws_subnet.scalble-pri-c.id]

  target_group_arns = [aws_lb_target_group.scalble-asg.arn]
  health_check_type = "ELB"
  health_check_grace_period = 60
  default_cooldown = 60

  launch_template {
    id      = aws_launch_template.scalble-template.id
    version = aws_launch_template.scalble-template.latest_version
  }

  tag {
    key                 = "Name"
    value               = "scalble"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup        = 60
    }
  }

  depends_on = [ aws_db_instance.scalbledb]
}
```
