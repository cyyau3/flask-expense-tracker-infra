# modules/cloudwatch/variables.tf
variable "project_name" {
  type        = string
  description = "Project name to prefix the log group"
}

variable "retention_in_days" {
  type        = number
  description = "Log retention period in days"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for resources"
}