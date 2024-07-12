variable "task_name" {
  description = "Name for the ECS task definition"
  type        = string
  default     = "my-ecs-task"
}

variable "container_name" {
  description = "Name for the container within the task"
  type        = string
  default     = "my-container"
}

variable "container_port" {
  description = "Port to expose on host"
  type        = number
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "log_group_ecs" {
  description = "Cloudwatch Cluster Logs"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "container_environments" {
  description = "Map of variables and static values to add to the task definition"
  type        = map(string)
  default     = {}
}

variable "container_secrets" {
  type        = map(string)
  description = "Map of variables and SSM locations to add to the task definition"
  default     = {}
}

variable "healthCheck" {
  type        = any
  description = "Container Health Check parameters"
  default     = {}
}

variable "container_memory" {
  description = "Container memory definition"
  type        = number
}

variable "container_cpu" {
  description = "Container CPU Definition"
  type        = number
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}
