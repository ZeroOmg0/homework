resource "aws_ec2_transit_gateway_route" "this" {
  transit_gateway_route_table_id = var.route_table_id
  destination_cidr_block         = var.destination_cidr_block
  transit_gateway_attachment_id  = var.attachment_id
}
