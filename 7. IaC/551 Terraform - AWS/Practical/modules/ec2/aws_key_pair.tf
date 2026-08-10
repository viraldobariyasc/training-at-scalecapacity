
resource "aws_key_pair" "demo-key-pair" {

  key_name = "demo-key-pair-ec2"
  public_key = file("${path.module}/ec2-ssh-key.pub")

  tags = {
    Name = "demo-key-pair"
  }
}