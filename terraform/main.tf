provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

module "ec2" {
  source = "./modules/ec2"

  ami               = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI for us-east-1
  instance_type     = var.instance_type
  subnet_id         = element(module.vpc.public_subnet_ids, 0)
  security_group_id = module.security_group.security_group_id
  key_name          = var.key_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "security_group_id" {
  value = module.security_group.security_group_id
}
