variable "tags" {
  description = "Tags to apply to the target group"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "name" {
  description = "Name of the target group"
  type        = string
}

variable "port" {
  description = "Port for the target group"
  type        = number
}

variable "protocol" {
  description = "Protocol for the target group"
  type        = string
}

variable "target_type" {
  description = "Target type for the target group"
  type        = string
}

variable "health_check" {
  description = "Health check configuration"
  type        = map(any)
  default     = {}
}
