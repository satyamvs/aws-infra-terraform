provider "aws" {
  region = "us-east-1"
}
terraform {
  required_version = ">=0.12.16"
}
module "vpc" {
  source = "./modules/vpc"
}

module "ec2-sg" {
  source = "./modules/securitygroups/"
  opstrain-vpc = module.vpc.opstrain-vpc
}

module "ec2"{

  source = "./modules/ec2"
  opstrain-private1 = module.vpc.opstrain-private1
  opstrain-private2 = module.vpc.opstrain-private2
  opstrain-public1 = module.vpc.opstrain-public1
  opstrain-vpc = module.vpc
  ec2-sg = module.ec2-sg.opstrain-ec2-sg
  opstrain-ec2-eip = module.vpc.opstrain-ec2-eip
}
module "ecs" {
  source = "./modules/ecs"

  ec2-sg = module.ec2-sg.opstrain-ec2-sg
  opstrain-public1 = module.vpc.opstrain-public1
  opstrain-public2 = module.vpc.opstrain-public2
}

