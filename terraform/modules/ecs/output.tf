output "ecs_cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.tm_ecs_cluster.id
}