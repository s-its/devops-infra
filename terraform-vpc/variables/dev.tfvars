aws_region = "ap-south-1"
vpc_name   = "eks-vpc"
ipv4_cidr  = "10.0.0.0/16"

azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnets  = ["10.0.1.0/27", "10.0.2.0/27", "10.0.3.0/27"]
private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

enable_nat_gateway = true

tags = {
  Terraform   = "true"
  Environment = "dev"
  ManagedBy   = "DevOps"
}