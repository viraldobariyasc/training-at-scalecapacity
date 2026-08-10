
resource "aws_autoscaling_group" "demo-asg" {

  name = "demo-asg"

  desired_capacity = 2
  min_size = 2
  max_size = 5

  health_check_grace_period = 300
  health_check_type = "ELB"

  vpc_zone_identifier = var.ec2-subnets

  launch_template {
    id = var.asg-lt-id
    version = "$Latest"
  }

  target_group_arns = [
    var.target-group-arn
  ]

}


resource "aws_autoscaling_policy" "demo-asg-cpu-policy" {

  name = "demo-asg-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.demo-asg.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {

    predefined_metric_specification{
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40
  }


}