
resource "aws_vpc" "demo-vpc" {

  cidr_block = var.vpc-cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "demo--vpc"
  }

}