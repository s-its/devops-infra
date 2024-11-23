resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet" {
  count = 2
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = element(var.subnet_cidr_blocks, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_security_group" "eks_sg" {
  vpc_id = aws_vpc.eks_vpc.id
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
  }
}
