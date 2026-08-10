
resource "aws_lb_listener" "app-listener" {
  load_balancer_arn = aws_lb.demo-alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found, buddy."
      status_code = "404"
    }
  }
}


resource "aws_lb_listener_rule" "app-listener-rule-1" {

  listener_arn = aws_lb_listener.app-listener.arn
  priority = 50

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.demo-tg.arn
  }

  condition {
    path_pattern {
      values = [
        "/*"
      ]
    }
  }
}