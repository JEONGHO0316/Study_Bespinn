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