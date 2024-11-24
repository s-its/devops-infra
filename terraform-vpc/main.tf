module "vpc" {
  source    = "git::https://github.com/s-its/aws-vpc.git?ref=v1.0.4"
  name      = var.vpc_name
  ipv4_cidr = var.ipv4_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway

  tags = var.tags
}