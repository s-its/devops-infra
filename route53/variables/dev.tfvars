aws_region   = "ap-south-1"
cluster_name = "my-eks-cluster"
tags = {
  Terraform   = "true"
  Environment = "dev"
  ManagedBy   = "DevOps"
}
domain_name = "shivaantainfotech.com"

applications = {
  grafana = "grafana"
}

