# root/outputs.tf
output "vpc_id" {
  value = module.networking.vpc_id
  description = "ID of the created VPC"
}

output "secret_arn" {
  value = module.secretsmanager.secret_arn
  description = "ARN of the Secrets Manager secret for DB credentials"
}

output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
  description = "URL of the ECR repository"
}

output "ecs_task_execution_role_arn" {
  value       = module.iam.ecs_task_execution_role_arn
  description = "IAM Role ARN for ECS Task Execution"
}

output "alb_dns" {
  value = module.alb.alb_dns_name
  description = "DNS name of the Application Load Balancer"
}

output "cloudwatch_log_group_name" {
  value       = module.cloudwatch.log_group_name
  description = "CloudWatch log group name"
}