variable "alb_name" {
  type        = string
  description = "Name of the Application Loadbalancer"
}

variable "alb_load_balancer_type" {
  type        = string
  description = "The type of load balancer to create (e.g., application or network). Typically set to 'application' for ALB."
}

variable "alb_sg_id" {
  type        = string
  description = "Security Group ID for the ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for the ALB"
}

variable "alb_target_group_name" {
  type        = string
  description = "Name of the ALB target group"
}

variable "alb_target_group_port" {
  type        = number
  description = "Port for the target group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
}

variable "alb_certificate_arn" {
  type        = string
  description = "ARN of the SSL certificate arn"
}