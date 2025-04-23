module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "tm-app-vpc"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

module "security_groups" {
  source  = "./modules/security_group"
  sg_name = "tm-app-sg"
  vpc_id  = module.vpc.vpc_id
}

module "application_loadbalancer" {
  source                 = "./modules/application_loadbalancer"
  alb_name               = "tm-app-alb"
  alb_load_balancer_type = "application"
  alb_sg_id              = module.security_groups.sg_id
  subnet_ids             = module.vpc.subnet_ids
  alb_target_group_name  = "tm-app-alb-target-group"
  alb_target_group_port  = 3000
  vpc_id                 = module.vpc.vpc_id
  alb_certificate_arn    = "arn:aws:acm:us-east-1:654654595460:certificate/cb5b26c0-b893-4129-81d3-1a286887e3cf"
}

module "ecs" {
  source               = "./modules/ecs"
  cluster_name         = "tm_ecs_cluster"
  task_family_namee    = "tm_app_task_def"
  task_cpu             = 4096 # total sum of container cpu x desired count
  task_memory          = 8192 # total sum of container memory x desired count
  container_cpu        = 4096
  container_memory     = 8192
  container_name       = "tm-app"
  container_image      = "654654595460.dkr.ecr.us-east-1.amazonaws.com/tm-app:latest"
  container_port       = 3000
  service_name         = "tm-app-service"
  desired_count        = 1
  subnet_ids           = module.vpc.subnet_ids
  security_groups      = [module.security_groups.sg_id]
  alb_target_group_arn = module.application_loadbalancer.target_group_arn
  http_listener_arn    = module.application_loadbalancer.http_listener_arn
  https_listener_arn   = module.application_loadbalancer.https_listener_arn
}

module "route53" {
  source            = "./modules/route53"
  zone_name         = "lab-yonisomar.com"
  cname_record_name = "demo.lab-yonisomar.com"
  ttl               = 300
  alb_dns_name      = module.application_loadbalancer.alb_url
}