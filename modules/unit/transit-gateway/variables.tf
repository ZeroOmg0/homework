variable "name" {
  description = "Name tag for the Transit Gateway"
  type        = string
}

variable "description" {
  description = "Description for the Transit Gateway"
  type        = string
  default     = ""
}

variable "amazon_side_asn" {
  description = "Amazon side ASN for the Transit Gateway"
  type        = number
  default     = 64512
}

variable "dns_support" {
  description = "DNS support setting for the Transit Gateway"
  type        = string
  default     = "enable"
}

variable "vpn_ecmp_support" {
  description = "VPN ECMP support setting"
  type        = string
  default     = "enable"
}

variable "default_route_table_association" {
  description = "Whether attachments are associated with default TGW route table"
  type        = string
  default     = "enable"
}

variable "default_route_table_propagation" {
  description = "Whether attachments propagate routes to default TGW route table"
  type        = string
  default     = "enable"
}

variable "tags" {
  description = "Tags to apply to the Transit Gateway"
  type        = map(string)
  default     = {}
}
