
resource "aws_eip" "demo-eip" {
  domain = "vpc"

  tags = {
    Name = "demo-eip"
  }
}

resource "aws_nat_gateway" "demo-ngw" {
  allocation_id = aws_eip.demo-eip.id
  subnet_id = aws_subnet.alb-subnet-1.id

  depends_on = [
    aws_internet_gateway.demo-igw
  ]

  tags = {
    Name = "demo-ngw"
  }
}