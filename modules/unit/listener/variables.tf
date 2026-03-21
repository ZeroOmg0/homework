variable "load_balancer_arn" {
  description = "Load balancer ARN"
  type        = string
}

variable "port" {
  description = "Listener port"
  type        = number
}

variable "protocol" {
  description = "Listener protocol"
  type        = string
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

variable "forward_target_group_arn" {
  description = "Target group ARN for forward action"
  type        = string
}
