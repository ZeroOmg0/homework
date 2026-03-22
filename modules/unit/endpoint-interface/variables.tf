variable "vpc_id" {
  type = string
}

variable "service_names" {
  type = list(string)
}

variable "security_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "private_dns_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  description = "Tags to apply to the VPC endpoints"
  type        = map(string)
  default     = {}
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
