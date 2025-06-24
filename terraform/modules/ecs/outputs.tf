# /terraform/modules/ecs/outputs.tf
output "cluster_name" {
  value = aws_ecs_cluster.this.name
  description = "ECS Cluster Name"
}

output "cluster_arn" {
  value       = aws_ecs_cluster.this.arn
  description = "ARN of the ECS Cluster"
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.this.arn
  description = "ARN of the ECS Task Definition"
}

output "service_name" {
  value       = aws_ecs_service.this.name
  description = "Name of the ECS Service"
}

output "log_group_name" {
  value       = aws_cloudwatch_log_group.ecs_log_group.name
  description = "CloudWatch Log Group for ECS"
}