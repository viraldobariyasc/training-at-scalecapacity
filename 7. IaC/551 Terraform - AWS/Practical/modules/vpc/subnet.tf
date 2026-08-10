
# ALB Subnets

resource "aws_subnet" "alb-subnet-1" {

  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.alb-cidr-1
  availability_zone = data.aws_availability_zones.all-azs.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "alb-subnet-1"
  }
}

resource "aws_subnet" "alb-subnet-2" {

  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.alb-cidr-2
  availability_zone = data.aws_availability_zones.all-azs.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "alb-subnet-2"
  }
}



# EC2 Subnets

resource "aws_subnet" "ec2-subnet-1" {

  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.ec2-cidr-1
  availability_zone = data.aws_availability_zones.all-azs.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "ec2-subnet-1"
  }
}

resource "aws_subnet" "ec2-subnet-2" {

  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.ec2-cidr-2
  availability_zone = data.aws_availability_zones.all-azs.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "ec2-subnet-2"
  }
}

# RDS Subnets

resource "aws_subnet" "rds-subnet-1" {

  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.rds-cidr-1
  availability_zone = data.aws_availability_zones.all-azs.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "rds-subnet-1"
  }
}

resource "aws_subnet" "rds-subnet-2" {

  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.rds-cidr-2
  availability_zone = data.aws_availability_zones.all-azs.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "rds-subnet-2"
  }
}