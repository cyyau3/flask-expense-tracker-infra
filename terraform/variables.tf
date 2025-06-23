variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "tags" {
    description = "Common tags for all resources"
    type        = map(string)
    default = {
        Project     = "flask-expense-tracker-infra"
        Environment = "dev"
        ManagedBy   = "Terraform"
  }
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block_1" {
    description = "CIDR block for public subnet 2"
    type = string
    default = "10.0.1.0/24"
}

variable "public_subnet_cidr_block_2" {
    description = "CIDR block for public subnet 2"
    type = string
    default = "10.0.2.0/24"
}

variable "private_subnet_cidr_block_1" {
    description = "CIDR block for private subnet 1"
    type = string
    default = "10.0.101.0/24"
}

variable "private_subnet_cidr_block_2" {
    description = "CIDR block for private subnet 2"
    type = string
    default = "10.0.102.0/24"
}

variable "project_name" {
  description = "The project name for tagging and resource naming"
  type        = string
}