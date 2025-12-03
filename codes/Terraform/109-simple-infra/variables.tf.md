
### 변수 정의 
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


variable "web_security_group_name" {
  description = "The name of the security ec2 group"
  type        = string
  # default     = "Allow_http"
}


# DB RDS 보안그룹
variable "rds_security_group_name" {
  description = "The name of the security rds group"
  type        = string
}
```