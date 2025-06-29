# /terraform/modules/iam/variables.tf
variable "project_name" {
  description = "Name of the project for naming IAM roles"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "secret_arn" {
  description = "Secret ARN for ECS task role access"
  type        = string
}