
### 입력 함수 
```
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

```