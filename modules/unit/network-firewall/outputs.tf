output "firewall_arn" {
  description = "ARN of the AWS Network Firewall"
  value       = aws_networkfirewall_firewall.this.arn
}

output "endpoint_id" {
  description = "VPC endpoint ID from the first AZ (dev simplification — no AZ affinity)"
  value       = local.endpoint_id
}
