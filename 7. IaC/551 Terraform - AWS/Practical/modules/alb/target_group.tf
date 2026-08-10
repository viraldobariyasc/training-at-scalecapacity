
resource "aws_lb_target_group" "demo-tg" {

  name = "demo-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance"

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200-299"
    interval = 30
    timeout = 5
    healthy_threshold = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "demo-tg"
  }
}