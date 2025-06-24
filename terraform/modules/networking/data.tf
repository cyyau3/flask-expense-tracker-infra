# /terraform/modules/networking/data.tf
data "aws_availability_zones" "available" {
  state = "available"
}