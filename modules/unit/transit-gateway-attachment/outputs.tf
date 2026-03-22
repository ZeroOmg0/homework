output "attachment_id" {
  description = "ID of the Transit Gateway VPC attachment, or null if not created"
  value       = var.tgw_id != null ? aws_ec2_transit_gateway_vpc_attachment.this[0].id : null
}
