variable "lb_arn" {
  description = "Load balancer arn"
  type        = list(string)
}

variable "acceptance_required" {
  description = "Whether the endpoint service requires endpoints to be accepted"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the endpoint service"
  type        = map(string)
  default     = {}
}

variable "allowed_principals" {
  description = "List of account IDs allowed to connect to endpoint service"
  type        = list(string)
  default     = []
}
