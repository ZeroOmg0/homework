variable "name" {
  description = "Name for the Network Firewall and policy"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to deploy the Network Firewall into"
  type        = string
}

variable "subnet_ids" {
  description = "List of firewall subnet IDs (one per AZ)"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
