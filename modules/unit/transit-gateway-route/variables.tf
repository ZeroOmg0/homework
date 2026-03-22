variable "route_table_id" {
  description = "Transit Gateway route table ID"
  type        = string
}

variable "destination_cidr_block" {
  description = "Destination CIDR block"
  type        = string
}

variable "attachment_id" {
  description = "Transit Gateway attachment ID"
  type        = string
}
