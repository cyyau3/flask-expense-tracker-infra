# modules/cloudwatch/main.tf
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/${var.project_name}-app"
  retention_in_days = var.retention_in_days
  tags = var.tags

  lifecycle {
    prevent_destroy = false
    create_before_destroy = true
  }
}