output "vpc_id" {
  value       = aws_vpc.tm_app_vpc.id
  description = "ID of the VPC"
}

output "subnet_ids" {
  value       = aws_subnet.public_tm_app_subnets[*].id
  description = "IDs of the public subnets"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.tm_app_igw.id
  description = "ID of the Internet Gateway"
}