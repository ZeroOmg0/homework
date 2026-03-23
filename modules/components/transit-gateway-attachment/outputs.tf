output "attachment_id" {
  value = module.attachment.attachment_id
}

output "association_id" {
  value = length(aws_ec2_transit_gateway_route_table_association.this) > 0 ? aws_ec2_transit_gateway_route_table_association.this[0].id : null
}

output "propagation_id" {
  value = length(aws_ec2_transit_gateway_route_table_propagation.this) > 0 ? aws_ec2_transit_gateway_route_table_propagation.this[0].id : null
}
