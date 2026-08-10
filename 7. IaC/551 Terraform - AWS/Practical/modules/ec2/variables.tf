
variable "alb-sg-id" {
  type = string
}

variable "vpc_id" {
  type = string
}

locals {
  ami_id = "ami-0b6c6ebed2801a5cb"
}

variable "rds_db_endpoint" {
  type = string
}