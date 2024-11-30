aws_region   = "ap-south-1"
cluster_name = "my-eks-cluster"
environment  = "dev"
tags = {
  Terraform   = "true"
  Environment = "dev"
  ManagedBy   = "DevOps"
}
node_group = {
  desired_node   = 2
  max_node       = 4
  min_node       = 1
  ami_type       = "CUSTOM"
  capacity_type  = "SPOT" # allowed value is "SPOT" and "ON_DEMAND"
  disk_size      = 30
  instance_types = ["t3.medium"]
}

enable_monitoring = false