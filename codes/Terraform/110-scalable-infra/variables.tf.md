### 입력 변수 

```
### Comput - EC2 ### 
variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = string
  # default     = ""
}

variable "instance_type" {
  description = "EC2 instance type for the web server."
  type        = string
  # default     = "t3.micro"
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  # default     = 80
}

### SG ###
# WEB 보안그룹 
variable "web_security_group_name" {
  description = "The name of the security ec2 group"
  type        = string
  # default     = "Allow_http"
}

# ALB 보안그룹
variable "alb_security_group_name" {
  description = "The Name of the security alb group"
  type = string
}

# DB RDS 보안그룹
variable "rds_security_group_name" {
  description = "The name of the security rds group"
  type        = string
}

### DB Input ###  
variable "db_id" {
  description = " The name of the security db id "
  type        = string
}

variable "db_passwd" {
  description = "The name of the security db id "
  type        = string
}

variable "db_endpoint" {
  description = "The name of the security db id "
  type        = string
}

variable "db_name" {
  description = "The name of the security db_name "
  type = string
}

### ALB 이름 생성 ###
variable "alb_name" {
  description = "The name of the alb"
  type        = string
  default     = "ex-alb"
}

### ALB DNS 주소 ###
output "alb-dns" {
  value = aws_lb.scalble-alb.dns_name
}
```