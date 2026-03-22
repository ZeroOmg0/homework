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

variable "tags" {
  description = "Tags to apply to the TGW attachment"
  type        = map(string)
  default     = {}
}

variable "default_route_table_association" {
  description = "Whether to associate with the TGW default route table"
  type        = bool
  default     = true
}

variable "default_route_table_propagation" {
  description = "Whether to propagate routes to the TGW default route table"
  type        = bool
  default     = true
}
