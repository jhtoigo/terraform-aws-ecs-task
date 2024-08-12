# Terraform AWS ECS Task Module

Terraform module witch create an ECS Task

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.secrets_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_exec_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_exec_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_exec_role_secrets_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_read_only_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | Container CPU Definition | `number` | n/a | yes |
| <a name="input_container_environments"></a> [container\_environments](#input\_container\_environments) | Map of variables and static values to add to the task definition | `map(string)` | `{}` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Docker image for the container | `string` | n/a | yes |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | Container memory definition | `number` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Name for the container within the task | `string` | `"my-container"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port to expose on host | `number` | n/a | yes |
| <a name="input_container_secrets"></a> [container\_secrets](#input\_container\_secrets) | Map of variables and SSM locations to add to the task definition | `map(string)` | `{}` | no |
| <a name="input_healthCheck"></a> [healthCheck](#input\_healthCheck) | Container Health Check parameters | `any` | `{}` | no |
| <a name="input_log_group_ecs"></a> [log\_group\_ecs](#input\_log\_group\_ecs) | Cloudwatch Cluster Logs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Tags to set for all resources | `map(string)` | n/a | yes |
| <a name="input_task_name"></a> [task\_name](#input\_task\_name) | Name for the ECS task definition | `string` | `"my-ecs-task"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | ARN of the ECS task definition |
<!-- END_TF_DOCS -->