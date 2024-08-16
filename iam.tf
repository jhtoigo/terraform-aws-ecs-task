resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.task_name}ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "secrets_manager_policy" {
  count       = length(var.secrets) > 0 ? 1 : 0
  name        = "${var.task_name}SecretsManagerPolicy"
  description = "Policy allowing GetSecretValue on multiple secrets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["secretsmanager:GetSecretValue"],
        Resource = var.secrets,
      }
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ssm_read_only_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  role       = aws_iam_role.ecs_task_execution_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_task_exec_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_task_execution_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_task_exec_role_secrets_manager_policy" {
  count      = length(aws_iam_policy.secrets_manager_policy) > 0 ? 1 : 0
  policy_arn = aws_iam_policy.secrets_manager_policy[count.index].arn
  role       = aws_iam_role.ecs_task_execution_role.name
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.task_name}EcsTaskRole"
  tags = merge(
    var.resource_tags
  )
  assume_role_policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_exec" {
  name        = "${var.task_name}EcsExecPolicy"
  path        = "/"
  description = "Policy to grant containers the permissions needed for communication between the managed SSM agent and the SSM service"
  tags = merge(
    var.resource_tags
  )
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_exec_role_policy" {
  policy_arn = aws_iam_policy.ecs_exec.arn
  role       = aws_iam_role.ecs_task_role.name
}