# /terraform/modules/secretsmanager/variables.tf
variable "project_name" {
  description = "Project name used for naming AWS resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "secret_string_json" {
  description = "The secret string to store (typically in JSON format)"
  type        = string
}