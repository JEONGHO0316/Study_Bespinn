### ALB DNS 출력 

```
output "alb_dns_name" {
  description = "The Domain name of the load balancer"
  value       = aws_lb.alb.dns_name
}
```