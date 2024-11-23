variable "aws_region" {
  description = "aws region provide for code"
  type        = string
  default     = "ap-south-1"
}

variable "s3_bucket_name" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
}


