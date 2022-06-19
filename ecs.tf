resource "aws_ecs_cluster" "rearc" {
  name = "rearc"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "rearc" {
  cluster_name = aws_ecs_cluster.rearc.name

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }
}

module "ecs-fargate" {
  source = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "ecs-fargate-rearc"
  vpc_id             = ""
  private_subnet_ids = ["10.0.1.0/24", "10.0.2.0/24"]

  cluster_id         = aws_ecs_cluster.rearc.id

  task_container_image   = "node:10"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  target_groups = [
    {
      target_group_name = "tg-fargate-rearc"
      container_port    = 80
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "test"
    Project = "Test"
  }
}