variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID where the NLB/ALB reside"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the NLB"
  type        = list(string)
}

variable "internal" {
  description = "Whether the NLB is internal"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection on the NLB"
  type        = bool
  default     = false
}

variable "acceptance_required" {
  description = "Whether the endpoint service requires endpoints to be accepted"
  type        = bool
  default     = false
}

variable "allowed_principals" {
  description = "List of account IDs allowed to connect to endpoint service"
  type        = list(string)
  default     = []
}

variable "alb_arn" {
  description = "ARN of the ALB to register as NLB target"
  type        = string
}

variable "listener_port" {
  description = "NLB listener port"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "NLB listener protocol"
  type        = string
  default     = "TCP"
}

variable "certificate_arn" {
  description = "Certificate ARN for TLS listener"
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "SSL policy for TLS listener"
  type        = string
  default     = null
}

variable "target_group_port" {
  description = "NLB target group port"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "NLB target group protocol"
  type        = string
  default     = "TCP"
}

variable "health_check" {
  description = "Health check configuration for the NLB target group"
  type        = map(any)
  default     = {}
}
