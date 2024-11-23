variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
