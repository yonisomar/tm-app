output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.tm_app_alb.arn
}

output "alb_url" {
  description = "The URL of the Application Load Balancer"
  value       = aws_lb.tm_app_alb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.tm_app_alb_target_group.arn
}

output "http_listener_arn" {
  description = "The ARN of the HTTP Listener"
  value       = aws_lb_listener.http_listener.arn
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS Listener"
  value       = aws_lb_listener.http_listener.arn
}