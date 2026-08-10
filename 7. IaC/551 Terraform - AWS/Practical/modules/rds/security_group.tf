

resource "aws_security_group" "rds-sg" {

  name = "rds-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http" {
  security_group_id = aws_security_group.rds-sg.id
  referenced_security_group_id = var.ec2-sg-id
  from_port = 3306
  to_port = 3306
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow-all" {
  security_group_id = aws_security_group.rds-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}