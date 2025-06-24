# modules/rds/variables.tf
variable "project_name" {
  type        = string
  description = "The name of the project for tagging."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the DB subnet group."
}

variable "security_group_rds" {
  type        = string
  description = "Security Group ID for RDS."
}

variable "db_identifier" {
  type        = string
  description = "RDS instance identifier."
}

variable "instance_class" {
  type        = string
  description = "RDS instance class (e.g., db.t3.micro)."
}

variable "db_name" {
  type        = string
  description = "Database name."
}

variable "db_username" {
  type        = string
  description = "Master username."
}

variable "db_password" {
  type        = string
  description = "Master password."
  sensitive   = true
}

variable "engine" {
  type = string
  description = "Database"
}

variable "engine_version" {
  type = string
  description = "Database version"
}

variable "allocated_storage" {
  type = number
  description = "Database storage size"
}