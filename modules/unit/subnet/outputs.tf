output "subnet_cidrs" {
  description = "List of CIDR blocks for the created subnets, ordered by AZ"
  value       = [for az in local.azs : aws_subnet.this[az].cidr_block]
}

output "subnet_ids" {
  description = "List of IDs for the created subnets, ordered by AZ"
  value       = [for az in local.azs : aws_subnet.this[az].id]
}
