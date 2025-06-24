# /terraform/modules/secretsmanager/main.tf
resource "aws_secretsmanager_secret" "db_creds" {
  name        = "${var.project_name}-db-creds"
  description = "Database credentials for the expense tracker app"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "db_creds_version" {
  secret_id     = aws_secretsmanager_secret.db_creds.id
  secret_string = var.secret_string_json
}