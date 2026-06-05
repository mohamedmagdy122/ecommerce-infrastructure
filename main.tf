module "vpc" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-vpc.git///?ref=main"

  name                 = local.name
  environment          = var.environment
  vpc_cidr             = local.vpc_cidr
  azs                  = local.azs
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}
module "eks_staging" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-eks.git///?ref=main"

  cluster_name       = "ecommerce-staging"
  cluster_version    = "1.31"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  node_instance_type = "t3.medium"
  node_desired_size  = 2
  node_min_size      = 1
  node_max_size      = 3
  environment        = "staging"
}
module "eks_production" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-eks.git///?ref=main"

  cluster_name       = "ecommerce-production"
  cluster_version    = "1.31"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  node_instance_type = "t3.medium"
  node_desired_size  = 2
  node_min_size      = 1
  node_max_size      = 3
  environment        = "production"
}
module "secrets_staging" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-secrets.git///?ref=main"

  name        = local.name
  environment = "staging"
}
module "secrets_production" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-secrets.git///?ref=main"

  name        = local.name
  environment = "production"
}

module "rds_staging" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-rds.git///?ref=main"

  name                = "ecommerce-staging-db"
  environment         = "staging"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  db_password         = module.secrets_staging.db_password
  allowed_cidr_blocks = [local.vpc_cidr]
}
module "rds_production" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-rds.git///?ref=main"

  name                = "ecommerce-production-db"
  environment         = "production"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  db_password         = module.secrets_production.db_password
  allowed_cidr_blocks = [local.vpc_cidr]
}
module "ec2_runners" {
  source = "git::https://github.com/mohamedmagdy122/tf-module-ec2-runners.git///?ref=main"

  name                = "${local.name}-runners"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  subnet_id           = module.vpc.public_subnet_ids[0]
  instance_count      = 4
  instance_type       = "t2.small"
  key_name            = var.key_name
  github_runner_token = var.github_runner_token
  github_repo_url     = var.github_repo_url
  runner_labels       = "self-hosted,linux,x64,ecommerce"
}
