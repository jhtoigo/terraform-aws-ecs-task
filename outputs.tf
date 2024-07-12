output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.ecs_task.arn
}

output "arn_values" {
  value = local.secrets_arns
}

output "container_secrets_values" {
  value = var.container_secrets
}