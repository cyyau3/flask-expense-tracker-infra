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

variable "ecs_max_capacity" {
  description = "Maximum number of ECS tasks that can run"
  type        = number
}

variable "ecs_min_capacity" {
  description = "Minimum number of ECS tasks that can run"
  type        = number
}

variable "ecs_scaling_target_value" {
  description = "Target value for ECS service CPU utilization"
  type        = number
}

variable "ecs_scale_in_cooldown" {
  description = "Cooldown time before scale in"
  type        = number
}

variable "ecs_scale_out_cooldown" {
  description = "Cooldown time before scale out"
  type        = number
}