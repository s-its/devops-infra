module "eks" {
  source            = "git::https://github.com/s-its/aws-eks.git?ref=master"
  cluster_name      = var.cluster_name
  private_subnets   = [for s in data.aws_subnet.private_subnet : s.id]
  environment       = var.environment
  enable_xray       = var.enable_xray
  enable_istio      = var.enable_istio
  tags              = var.tags
  node_group        = var.node_group
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}
