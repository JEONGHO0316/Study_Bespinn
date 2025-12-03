
### ec2 ### 
output "public_ip" {
  value = "${aws_instance.web_pub.public_ip}:${var.server_port}"
}

output "private_ip" {
  value = "${aws_instance.web_pri.private_ip}:${var.server_port}"
}

### DB ### 
output "db_endpoint" {
  value = aws_db_instance.tfdb.address # Address 와 Port 같이 출력 
}

