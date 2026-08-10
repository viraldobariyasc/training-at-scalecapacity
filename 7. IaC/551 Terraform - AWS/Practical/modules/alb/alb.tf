

resource "aws_lb" "demo-alb" {

  name = "demo-alb"
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.alb-sg.id
  ]
  subnets = var.alb-subnets

  internal = false
  enable_deletion_protection = false
  idle_timeout = 60

  tags = {
    Name = "demo-ALB"
  }
}