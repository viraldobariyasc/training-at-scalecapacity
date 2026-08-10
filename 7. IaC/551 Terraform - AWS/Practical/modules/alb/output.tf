
output "alb-sg-id" {
  value = aws_security_group.alb-sg.id
}

output "target-group-arn" {
  value = aws_lb_target_group.demo-tg.arn
}