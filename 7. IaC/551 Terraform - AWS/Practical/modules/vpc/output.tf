
output "vpc_id" {
  value = aws_vpc.demo-vpc.id
}

output "rds-subnet-ids" {
  value = [
    aws_subnet.rds-subnet-1.id,
    aws_subnet.rds-subnet-2.id
  ]
}

output "ec2-subnet-ids" {
  value = [
    aws_subnet.ec2-subnet-1.id,
    aws_subnet.ec2-subnet-2.id
  ]
}

output "alb-subnet-ids" {
  value = [
    aws_subnet.alb-subnet-1.id,
    aws_subnet.alb-subnet-2.id
  ]
}