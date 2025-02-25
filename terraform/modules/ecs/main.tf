# Define ECS Cluster
resource "aws_ecs_cluster" "tm_ecs_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Define ECS Task Definition
resource "aws_ecs_task_definition" "tm_ecs_task_definition" {
  family                   = var.task_family_namee
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
  }])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
}

# Define IAM Role for ECS Execution
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach ECS Execution Role Policy (Includes ECR Access)
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Define ECS Service
resource "aws_ecs_service" "tm_ecs_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.tm_ecs_cluster.id
  task_definition = aws_ecs_task_definition.tm_ecs_task_definition.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "tm-app"
    container_port   = 3000
  }

  tags = {
    Name = var.service_name
  }

  depends_on = [
    var.http_listener_arn,
    var.https_listener_arn,
    aws_iam_role_policy_attachment.ecs_execution_policy
  ]
}