# /terraform/modules/alb/variables.tf
variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB will be deployed"
  type = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type = list(string)
}

variable "security_group_alb" {
  description = "ALB security group ID"
  type = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}