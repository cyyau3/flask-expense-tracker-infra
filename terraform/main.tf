# main.tf
module "networking" {
  source = "./modules/vpc"

  vpc_cidr_block               = var.vpc_cidr_block
  public_subnet_cidr_block_1   = var.public_subnet_cidr_block_1
  public_subnet_cidr_block_2   = var.public_subnet_cidr_block_2
  private_subnet_cidr_block_1  = var.private_subnet_cidr_block_1
  private_subnet_cidr_block_2  = var.private_subnet_cidr_block_2
}