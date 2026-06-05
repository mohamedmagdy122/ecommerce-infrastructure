output "vpc_id" { value = module.vpc.vpc_id }
output "eks_staging_cluster_name" { value = module.eks_staging.cluster_name }
output "eks_production_cluster_name" { value = module.eks_production.cluster_name }
output "rds_staging_endpoint" { value = module.rds_staging.endpoint }
output "rds_production_endpoint" { value = module.rds_production.endpoint }
output "runner_private_ips" { value = module.ec2_runners.runner_private_ips }
