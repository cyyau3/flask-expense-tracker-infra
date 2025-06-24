variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "tags" {
    description = "Common tags for all resources"
    type        = map(string)
    default = {
        Project     = "flask-expense-tracker-infra"
        Environment = "dev"
        ManagedBy   = "Terraform"
  }
}

variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr_block_1" {
    description = "CIDR block for public subnet 2"
    type = string
    default = "10.0.1.0/24"
}

variable "public_subnet_cidr_block_2" {
    description = "CIDR block for public subnet 2"
    type = string
    default = "10.0.2.0/24"
}

variable "private_subnet_cidr_block_1" {
    description = "CIDR block for private subnet 1"
    type = string
    default = "10.0.101.0/24"
}

variable "private_subnet_cidr_block_2" {
    description = "CIDR block for private subnet 2"
    type = string
    default = "10.0.102.0/24"
}

variable "project_name" {
  description = "The project name for tagging and resource naming"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS listener"
  type        = string
}

variable "secret_string_json" {
  type        = string
  description = "JSON string for the database credentials"
}

variable "secret_name" {
  description = "Name of the secret to be stored in AWS Secrets Manager"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage (GB)"
  type        = number
}

variable "engine" {
  description = "PostgreSQL"
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_username" {
  description = "Master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "ecs_min_capacity" {
  description = "Minimum number of ECS tasks to run"
  type        = number
}

variable "ecs_max_capacity" {
  description = "Maximum number of ECS tasks to run"
  type        = number
}

variable "ecs_scaling_target_value" {
  description = "Target CPU utilization percentage for scaling"
  type        = number
}

variable "ecs_scale_in_cooldown" {
  description = "Cooldown period (in seconds) before scaling in"
  type        = number
}

variable "ecs_scale_out_cooldown" {
  description = "Cooldown period (in seconds) before scaling out"
  type        = number
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name to use (e.g., app.example.com)"
  type        = string
}