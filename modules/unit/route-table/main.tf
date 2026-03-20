resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                 = route.value.cidr_block
      gateway_id                 = try(route.value.gateway_id, null)
      nat_gateway_id             = try(route.value.nat_gateway_id, null)
      transit_gateway_id         = try(route.value.transit_gateway_id, null)
      vpc_peering_connection_id  = try(route.value.vpc_peering_connection_id, null)
      egress_only_gateway_id     = try(route.value.egress_only_gateway_id, null)
      vpc_endpoint_id            = try(route.value.vpc_endpoint_id, null)
      network_interface_id       = try(route.value.network_interface_id, null)
      instance_id                = try(route.value.instance_id, null)
    }
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}

resource "aws_route_table_association" "this" {
  for_each = toset(var.subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.this.id
}
