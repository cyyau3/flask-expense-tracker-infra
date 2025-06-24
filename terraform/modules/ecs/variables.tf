# /terraform/modules/ecs/variables.tf
variable "project_name" {}
variable "region" {}
variable "tags" {}

variable "ecr_repo_url" {}
variable "execution_role_arn" {}
variable "task_role_arn" {}

variable "private_subnet_ids" {
  type = list(string)
}

variable "security_group_ecs" {}
variable "target_group_arn" {}
variable "listener_rule_arn" {}

variable "log_group_name" {
  type        = string
  description = "Name of the CloudWatch log group for ECS task logging"
}

variable "secret_name" {}