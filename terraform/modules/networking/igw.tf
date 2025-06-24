# /terraform/modules/networking/igw.tf
resource "aws_internet_gateway" "et_modular_gw" {
  vpc_id = aws_vpc.et_modular_vpc.id
}

# route table for public subnets
resource "aws_route_table" "et_modular_route_table_1" {
  vpc_id = aws_vpc.et_modular_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.et_modular_gw.id
  }
}

# route table association for public subnets
resource "aws_route_table_association" "et_modular_public_rta_1" {
  subnet_id      = aws_subnet.et_modular_public_subnet_1.id
  route_table_id = aws_route_table.et_modular_route_table_1.id
}

resource "aws_route_table_association" "et_modular_public_rta_2" {
  subnet_id      = aws_subnet.et_modular_public_subnet_2.id
  route_table_id = aws_route_table.et_modular_route_table_1.id
}