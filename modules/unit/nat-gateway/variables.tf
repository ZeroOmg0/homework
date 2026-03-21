variable "name" {
  description = "Name tag for the NAT Gateway"
  type        = string
}

variable "subnet_id" {
  description = "ID of the public subnet to place the NAT Gateway in"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the NAT Gateway and EIP"
  type        = map(string)
  default     = {}
}
