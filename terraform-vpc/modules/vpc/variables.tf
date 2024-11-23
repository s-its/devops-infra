variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets"
  type        = list(string)
}
