variable "cluster_name" {
  type        = string
  description = "Name of ECS cluster"
}

variable "task_family_namee" {
  type        = string
  description = "ECS task family name"
}

variable "task_cpu" {
  type        = number
  description = "ECS task definition cpu"
}

variable "task_memory" {
  type        = number
  description = "ECS task definition memory"
}

variable "container_name" {
  type        = string
  description = "ECS container name"
  default     = "tm-app-container"
}

variable "container_image" {
  type        = string
  description = "ECS container image"
}

variable "container_port" {
  type        = number
  description = "ECS container port and host port"
}

variable "container_cpu" {
  type        = number
  description = "ECS container cpu"
}

variable "container_memory" {
  type        = number
  description = "ECS container memory"
}

variable "service_name" {
  type        = string
  description = "ECS service name"
}

variable "desired_count" {
  type        = number
  description = "Number of desired instances for ECS Service"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for ECS Service"
}

variable "security_groups" {
  type        = list(string)
  description = "Security Groups for ECS Service"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ECS Service ALB target group ARN"
}

variable "http_listener_arn" {
  type        = string
  description = "The ARN of the HTTP Listener"
}

variable "https_listener_arn" {
  type        = string
  description = "The ARN of the HTTPS Listener"
}
