# CIDR block for the VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# VPC Name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# List of CIDR blocks for the public subnets
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

# List of Availability Zones for the subnets
variable "availability_zones" {
  description = "List of Availability Zones for the subnets"
  type        = list(string)
}