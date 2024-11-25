variable "aws_region" {
  description = "aws region provide for code"
  type        = string
  default     = "ap-south-1"
}
variable "environment" {
  type        = string
  description = "Environment for tagging"
  default     = "production"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "enable_xray" {
  type        = bool
  description = "Flag to enable or disable X-Ray monitoring"
  default     = false
}
variable "enable_istio" {
  type        = bool
  description = "Flag to enable or disable Istio installation"
  default     = false
}

variable "enable_monitoring" {
  type        = bool
  description = "Flag to enable or disable Prometheus and Grafana"
  default     = false
}

variable "node_group" {
  description = "AWS EKS Default node group"
  type = object({
    desired_node   = number
    max_node       = number
    min_node       = number
    ami_type       = string
    capacity_type  = string
    disk_size      = number
    instance_types = list(string)
  })
  default = {
    desired_node   = 2
    max_node       = 4
    min_node       = 1
    ami_type       = "CUSTOM"
    capacity_type  = "SPOT"
    disk_size      = 30
    instance_types = ["t3.medium"]
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
