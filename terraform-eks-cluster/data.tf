
data "aws_subnet" "private_subnet" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
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

data "aws_vpc" "eks_vpc" {
  filter {
    name  = "tag:ManagedBy"
    values = ["DevOps"]
  }
}

data "aws_eks_cluster" "main" {
  depends_on = [module.eks.eks_cluster]
  name = module.eks.eks_cluster.name
}

data "aws_eks_cluster_auth" "main" {
  depends_on = [module.eks.eks_cluster]
  name = module.eks.eks_cluster.name
}