
resource "aws_security_group" "ec2-sg" {

  name = "ec2-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.ec2-sg.id
  referenced_security_group_id = var.alb-sg-id
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}