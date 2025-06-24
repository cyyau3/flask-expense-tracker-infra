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

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  tags         = var.tags
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
  listener_rule_arn   = module.alb.alb_listener_rule_arn
}