resource "aws_ecs_task_definition" "ecs_task" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  tags = merge(
    var.resource_tags
  )
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      linuxParameters = {
        "initProcessEnabled" : true
      },
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.log_group_ecs
          awslogs-region        = var.region
          awslogs-stream-prefix = var.container_name
        }
      },
      portMappings = [
        {
          name          = var.container_name
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ],
      healthCheck = length(var.healthCheck) > 0 ? var.healthCheck : null

      environment = [for k, v in var.container_environments : { name : k, value : v }]
      secrets     = [for k, v in var.container_secrets : { name : k, valueFrom : v }]
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}