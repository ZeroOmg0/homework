variable "name" {
  description = "Name tag for the route table"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets associated with this route table"
  type        = list(string)
  default     = []
}

variable "routes" {
  description = "Routes for the route table"
  type = list(object({
    cidr_block                = string
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    egress_only_gateway_id    = optional(string)
    vpc_endpoint_id           = optional(string)
    network_interface_id      = optional(string)
    instance_id               = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the route table"
  type        = map(string)
  default     = {}
}
