module "vpc" {
  source         = "git::https://github.com/hemanchandra-devops/terraform-aws-vpc.git"
  project        = var.project
  environment    = var.environment
  vpc_cidr_block = var.vpc_cidr_block
  vpc_tags       = var.vpc_tags

  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs

  is_peering_requried = var.is_peering_requried

}