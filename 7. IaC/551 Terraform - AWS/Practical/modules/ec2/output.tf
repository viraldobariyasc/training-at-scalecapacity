
output "ec2-sg-id" {
  value = aws_security_group.ec2-sg.id
}

output "launch-template-id" {
  value = aws_launch_template.demo-launch-template.id
}