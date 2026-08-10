

resource "aws_launch_template" "demo-launch-template" {

  name_prefix = "demo-lt-"
  image_id = local.ami_id
  instance_type = "t3.micro"

  key_name = aws_key_pair.demo-key-pair.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2-sg.id
  ]

  user_data = base64encode(templatefile("${path.module}/startup.sh", {
    rds_endpoint = var.rds_db_endpoint
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "demo-instance"
    }
  }
}