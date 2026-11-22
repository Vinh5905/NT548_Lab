terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "nt548-lab1-vpc"

  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}

output "nat_eip" {
  value = module.vpc.nat_eip
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}


output "default_security_group_id" {
  value = module.vpc.default_security_group_id
}
