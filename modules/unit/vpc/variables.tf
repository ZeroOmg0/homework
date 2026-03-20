variable "name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Whether DNS resolution is supported"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Whether DNS hostnames are supported"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
  default     = {}
}
