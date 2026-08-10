
resource "aws_security_group" "alb-sg" {

  name = "alb-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}