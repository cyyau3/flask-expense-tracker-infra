# outputs.tf
output "vpc_id" {
  description = "The ID of the VPC"
  value = aws_vpc.et_modular_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the 2 public subnets"
  value = [aws_subnet.et_modular_public_subnet_1.id, aws_subnet.et_modular_public_subnet_2.id]
}

output "private_subnet_ids" {
  description = "The IDs of the 2 private subnets"
  value = [aws_subnet.et_modular_private_subnet_1.id, aws_subnet.et_modular_private_subnet_2.id]
}

output "nat_gateway_id" {
  description = "The IDs of the NAT Gateway"
  value = aws_nat_gateway.et_modular_nat_gw.id
}