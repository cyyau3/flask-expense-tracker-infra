# subnets.tf
resource "aws_subnet" "et_modular_public_subnet_1" {
  vpc_id     = aws_vpc.et_modular_vpc.id
  cidr_block = var.public_subnet_cidr_block_1
  map_public_ip_on_launch = true

  tags = {
    Name = "et_modular_public_subnet_1"
  }
}

resource "aws_subnet" "et_modular_public_subnet_2" {
  vpc_id     = aws_vpc.et_modular_vpc.id
  cidr_block = var.public_subnet_cidr_block_2
  map_public_ip_on_launch = true

  tags = {
    Name = "et_modular_public_subnet_2"
  }
}

resource "aws_subnet" "et_modular_private_subnet_1" {
  vpc_id     = aws_vpc.et_modular_vpc.id
  cidr_block = var.private_subnet_cidr_block_1
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "et_modular_private_subnet_1"
  }
}

resource "aws_subnet" "et_modular_private_subnet_2" {
  vpc_id     = aws_vpc.et_modular_vpc.id
  cidr_block = var.private_subnet_cidr_block_2
  availability_zone = data.aws_availability_zones.available.names[1]
  
  tags = {
    Name = "et_modular_private_subnet_2"
  }
}