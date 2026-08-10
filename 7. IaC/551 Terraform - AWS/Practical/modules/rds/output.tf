
output "rds-db-endpoint" {
  value = aws_db_instance.rds-db-instance.endpoint
  description = "this is endpoint of the rds db"
}