
module "module-vpc" {
  source = "./modules/vpc"

  vpc-cidr = "10.0.0.0/16"
  alb-cidr-1 = "10.0.0.0/24"
  alb-cidr-2 = "10.0.1.0/24"
  ec2-cidr-1 = "10.0.50.0/24"
  ec2-cidr-2 = "10.0.51.0/24"
  rds-cidr-1 = "10.0.100.0/24"
  rds-cidr-2 = "10.0.101.0/24"
}


module "module-alb" {
  source = "./modules/alb"

  vpc_id = module.module-vpc.vpc_id
  alb-subnets = module.module-vpc.alb-subnet-ids
}



module "module-ec2" {
  source = "./modules/ec2"

  alb-sg-id = module.module-alb.alb-sg-id
  vpc_id = module.module-vpc.vpc_id
  rds_db_endpoint = module.module-rds.rds-db-endpoint
}


module "module-asg" {
  source = "./modules/asg"

  asg-lt-id = module.module-ec2.launch-template-id
  ec2-subnets = module.module-vpc.ec2-subnet-ids
  target-group-arn = module.module-alb.target-group-arn
}



module "module-rds" {
  source = "./modules/rds"

  ec2-sg-id = module.module-ec2.ec2-sg-id
  rds-subnet-ids = module.module-vpc.rds-subnet-ids
  vpc_id = module.module-vpc.vpc_id
}