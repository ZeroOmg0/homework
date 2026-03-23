module "attachment" {
  source = "../../unit/transit-gateway-attachment"

  name       = var.name
  tgw_id     = var.tgw_id
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  tags       = var.tags

  default_route_table_association = false
  default_route_table_propagation = false
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.enable_association && var.tgw_id != null && var.route_table_id != null ? 1 : 0

  transit_gateway_attachment_id  = module.attachment.attachment_id
  transit_gateway_route_table_id = var.route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  count = var.enable_propagation && var.tgw_id != null && var.route_table_id != null ? 1 : 0

  transit_gateway_attachment_id  = module.attachment.attachment_id
  transit_gateway_route_table_id = var.route_table_id
}
