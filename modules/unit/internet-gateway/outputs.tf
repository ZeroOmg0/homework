output "igw_id" {
  description = "ID of the Internet Gateway, or null if not created"
  value       = try(aws_internet_gateway.this[0].id, null)
}
