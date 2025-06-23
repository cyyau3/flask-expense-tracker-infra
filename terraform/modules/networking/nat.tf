# nat.tf
# Allocate an Elastic IP for NAT
resource "aws_eip" "et_modular_nat_eip" {
    tags = {
      Name = "et_modular_nat_eip"
  }
}

# NAT Gateway in public subnet
resource "aws_nat_gateway" "et_modular_nat_gw" {
  allocation_id = aws_eip.et_modular_nat_eip.id
  subnet_id     = aws_subnet.et_modular_public_subnet_1.id

  tags = {
    Name = "et_modular_nat_gw"
  }

  depends_on = [aws_internet_gateway.et_modular_gw]
}

# Add NAT route to private route table
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.et_modular_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.et_modular_nat_gw.id
}

# route table for private subnets
resource "aws_route_table" "et_modular_route_table_2" {
  vpc_id = aws_vpc.et_modular_vpc.id

  tags = {
    Name = "et_modular_private_rt"
  }
}

# route table associations for private subnets
resource "aws_route_table_association" "et_modular_private_rta_1" {
  subnet_id      = aws_subnet.et_modular_private_subnet_1.id
  route_table_id = aws_route_table.et_modular_route_table_2.id
}

resource "aws_route_table_association" "et_modular_private_rta_2" {
  subnet_id      = aws_subnet.et_modular_private_subnet_2.id
  route_table_id = aws_route_table.et_modular_route_table_2.id
}