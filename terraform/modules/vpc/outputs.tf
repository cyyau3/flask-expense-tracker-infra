# outputs.tf
output "vpc_id" {
  value = aws_vpc.et_modular_vpc.id
}

output "public_subnet_ids" {
  value = [aws_subnet.et_modular_public_subnet_1.id, aws_subnet.et_modular_public_subnet_2.id]
}

output "private_subnet_ids" {
  value = [aws_subnet.et_modular_private_subnet_1.id, aws_subnet.et_modular_private_subnet_2.id]
}

output "nat_gateway_id" {
  value = aws_nat_gateway.et_modular_nat_gw.id
}