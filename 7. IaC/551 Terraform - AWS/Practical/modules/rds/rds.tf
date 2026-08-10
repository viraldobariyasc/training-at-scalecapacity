
resource "aws_db_subnet_group" "rds-subnet-group" {

  name = "rds-subnet-group"
  subnet_ids = var.rds-subnet-ids

}

resource "aws_db_instance" "rds-db-instance" {
  identifier = "rds-db-instance"

  engine = "mysql" 
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  username = "root"
  password = "root1234"

  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name

  vpc_security_group_ids = [aws_security_group.rds-sg.id]

  publicly_accessible = false

  skip_final_snapshot = true

  multi_az = true

  tags = {
    Name = "rds-db-instance"
  }
}