variable "name" {
  description = "Name prefix for the subnets"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of subnet CIDRs, one per AZ"
  type        = list(string)
}

variable "availability_zones" {
  description = "Optional list of Availability Zones aligned with subnet_cidrs"
  type        = list(string)
  default     = null
}

variable "map_public_ip_on_launch" {
  description = "Whether to auto-assign public IPs"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the subnets"
  type        = map(string)
  default     = {}
}
