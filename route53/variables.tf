variable "aws_region" {
  description = "aws region provide for code"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "Base domain for Route 53"
}

variable "applications" {
  description = "Map of applications to subdomains"
  type        = map(string)
  default = {
    grafana = "grafana"
    app1    = "app1"
  }
}


