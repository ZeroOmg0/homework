variable "name" {
  description = "Name tag for the TGW attachment"
  type        = string
}

variable "tgw_id" {
  description = "Transit Gateway ID"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "VPC ID to attach"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the attachment"
  type        = list(string)
}

variable "route_table_id" {
  description = "Transit Gateway route table ID to associate/propagate"
  type        = string
  default     = null
}

variable "enable_association" {
  description = "Whether to associate the attachment with the route table"
  type        = bool
  default     = true
}

variable "enable_propagation" {
  description = "Whether to propagate routes to the route table"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
