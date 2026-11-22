terraform {
  required_version = ">= 1.10.0"

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


# ==========================================
# EC2 SSH Key Pair
# ==========================================

resource "aws_key_pair" "lab" {
  key_name   = "nt548-lab2-bai1-key"
  public_key = trimspace(var.ssh_public_key)

  tags = {
    Name = "nt548-lab2-bai1-key"
  }
}


# ==========================================
# Public EC2
# ==========================================

module "ec2_public" {
  source = "./modules/ec2"

  instance_name = "nt548-lab1-public-ec2"
  instance_type = "t3.micro"

  subnet_id = module.vpc.public_subnet_id

  security_group_ids = [module.security_groups.public_id]

  key_name                    = aws_key_pair.lab.key_name
  associate_public_ip_address = true
}

# ==========================================
# Private EC2
# ==========================================

module "ec2_private" {
  source = "./modules/ec2"

  instance_name = "nt548-lab1-private-ec2"
  instance_type = "t3.micro"

  subnet_id = module.vpc.private_subnet_id

  security_group_ids = [module.security_groups.private_id]

  key_name                    = aws_key_pair.lab.key_name
  associate_public_ip_address = false
}


# ==========================================
# Public EC2 Outputs
# ==========================================

output "public_ec2_id" {
  value = module.ec2_public.instance_id
}

output "public_ec2_public_ip" {
  value = module.ec2_public.public_ip
}

output "public_ec2_private_ip" {
  value = module.ec2_public.private_ip
}

# ==========================================
# Private EC2 Outputs
# ==========================================

output "private_ec2_id" {
  value = module.ec2_private.instance_id
}

output "private_ec2_private_ip" {
  value = module.ec2_private.private_ip
}

module "security_groups" {
  source           = "./modules/security_groups"
  vpc_id           = module.vpc.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
}