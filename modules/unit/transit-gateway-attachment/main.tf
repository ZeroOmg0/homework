resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.tgw_id == null ? 0 : 1

  transit_gateway_id                              = var.tgw_id
  vpc_id                                          = var.vpc_id
  subnet_ids                                      = var.subnet_ids
  dns_support                                     = "enable"
  transit_gateway_default_route_table_association = var.default_route_table_association
  transit_gateway_default_route_table_propagation = var.default_route_table_propagation

  tags = merge(var.tags, {
    Name = var.name
  })
}
