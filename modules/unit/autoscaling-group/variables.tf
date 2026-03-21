variable "name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the ASG"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired capacity"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum size"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum size"
  type        = number
  default     = 4
}

variable "target_group_arns" {
  description = "Target group ARNs to attach"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "Health check type"
  type        = string
  default     = "ELB"
}

variable "health_check_grace_period" {
  description = "Health check grace period in seconds"
  type        = number
  default     = 60
}

variable "launch_template_id" {
  description = "Launch template ID"
  type        = string
}

variable "launch_template_version" {
  description = "Launch template version"
  type        = string
  default     = "$Latest"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
