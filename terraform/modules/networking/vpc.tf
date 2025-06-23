# vpc.tf 
# VPC
resource "aws_vpc" "et_modular_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "et_modular_vpc"
  }
}