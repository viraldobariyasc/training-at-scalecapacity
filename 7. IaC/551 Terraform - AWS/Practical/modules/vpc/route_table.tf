
# Public Route table

resource "aws_route_table" "public-rt" {

  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "public-RT"
  }
}


resource "aws_route_table_association" "public-rt-alb-1-subnet" {
  subnet_id = aws_subnet.alb-subnet-1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-rt-alb-2-subnet" {
  subnet_id = aws_subnet.alb-subnet-2.id
  route_table_id = aws_route_table.public-rt.id
}



# Private Route table

resource "aws_route_table" "private-rt" {

  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.demo-ngw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private-rt-ec2-subnet-1" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.ec2-subnet-1.id
}

resource "aws_route_table_association" "private-rt-ec2-subnet-2" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.ec2-subnet-2.id
}

resource "aws_route_table_association" "private-rt-rds-subnet-1" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.rds-subnet-1.id
}

resource "aws_route_table_association" "private-rt-rds-subnet-2" {
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.rds-subnet-2.id
}
