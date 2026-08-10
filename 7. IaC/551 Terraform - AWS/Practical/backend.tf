# terraform {
#   backend "s3" {
#     bucket         = "three-tier-tf-state-bucket-992729"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-lock-table"
#     encrypt        = true
#   }
# }
