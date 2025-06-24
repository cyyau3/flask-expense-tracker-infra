# root/main.tf
module "networking" {
  source = "./modules/networking"
  vpc_cidr_block               = var.vpc_cidr_block
  public_subnet_cidr_block_1   = var.public_subnet_cidr_block_1
  public_subnet_cidr_block_2   = var.public_subnet_cidr_block_2
  private_subnet_cidr_block_1  = var.private_subnet_cidr_block_1
  private_subnet_cidr_block_2  = var.private_subnet_cidr_block_2
  tags = var.tags
}

module "ecr" {
  source = "./modules/ecr"
  name   = "flask-expense-tracker-ecr"
}

module "secretsmanager" {
  source        = "./modules/secretsmanager"
  project_name  = var.project_name
  tags          = var.tags
  secret_name   = var.secret_name
  secret_string_json = var.secret_string_json
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags

  secret_arn = module.secretsmanager.secret_arn
}

module "alb" {
  source = "./modules/alb"
  project_name        = var.project_name
  vpc_id              = module.networking.vpc_id
  public_subnet_ids   = module.networking.public_subnet_ids
  security_group_alb  = module.networking.alb_sg
  acm_certificate_arn = var.acm_certificate_arn
  tags                = var.tags
}

module "ecs" {
  source              = "./modules/ecs"
  project_name        = var.project_name
  region              = var.aws_region
  tags                = var.tags

  ecr_repo_url        = module.ecr.ecr_repository_url
  execution_role_arn  = module.iam.ecs_task_execution_role_arn
  task_role_arn       = module.iam.ecs_task_role_arn
  private_subnet_ids  = module.networking.private_subnet_ids
  security_group_ecs  = module.networking.ecs_sg
  target_group_arn    = module.alb.alb_target_group_arn
  listener_rule_arn  = module.alb.alb_listener_https_arn
  log_group_name      = module.cloudwatch.log_group_name
  secret_name = module.secretsmanager.secret_name

  ecs_min_capacity         = var.ecs_min_capacity
  ecs_max_capacity         = var.ecs_max_capacity
  ecs_scaling_target_value = var.ecs_scaling_target_value
  ecs_scale_in_cooldown    = var.ecs_scale_in_cooldown
  ecs_scale_out_cooldown   = var.ecs_scale_out_cooldown
}

module "rds" {
  source = "./modules/rds"

  project_name        = var.project_name
  instance_class   = var.db_instance_class
  allocated_storage   = var.allocated_storage
  engine = var.engine
  engine_version      = var.engine_version
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  private_subnet_ids  = module.networking.private_subnet_ids
  security_group_rds  = module.networking.rds_sg
  db_identifier       = var.db_identifier
}

module "cloudwatch" {
  source            = "./modules/cloudwatch"
  project_name      = var.project_name
  retention_in_days = 7
  tags              = var.tags
}