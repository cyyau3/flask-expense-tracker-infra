# vpc.tf 
# VPC
resource "aws_vpc" "et_modular_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "et_modular_vpc"
  }
}