resource "aws_vpc_endpoint" "interface" {
  for_each = toset(var.service_names)

  service_name      = each.key
  vpc_endpoint_type = "Interface"

  vpc_id              = var.vpc_id
  subnet_ids          = var.subnet_ids
  private_dns_enabled = var.private_dns_enabled

  security_group_ids = [module.security_group.security_group_id]

  tags = merge(var.tags, {
    Name = each.key
  })

}

module "security_group" {
  source = "../security-group"

  name                     = var.security_group_name
  vpc_id                   = var.vpc_id
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  egress_with_cidr_blocks  = var.egress_with_cidr_blocks
  tags                     = var.tags
}
