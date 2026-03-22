variable "name" {
  description = "Name for the load balancer"
  type        = string
}

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
  description = "VPC ID for the load balancer"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the load balancer"
  type        = list(string)
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "port" {
  description = "Listener port"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Listener protocol"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Target type for the target group"
  type        = string
  default     = "ip"
}

variable "target_ips" {
  description = "IP targets to attach to the target group"
  type        = list(string)
  default     = []
}

variable "health_check" {
  description = "Health check configuration"
  type        = map(any)
  default     = {}
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection on the load balancer"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "Certificate ARN for TLS listeners"
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "SSL policy for TLS listeners"
  type        = string
  default     = null
}

variable "ingress_with_cidr_blocks" {
  description = "Ingress rules for the load balancer security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "egress_with_cidr_blocks" {
  description = "Egress rules for the load balancer security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
