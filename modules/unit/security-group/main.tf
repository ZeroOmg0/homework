resource "aws_security_group" "this" {
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = var.name
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  for_each = {
    for rule in var.ingress_with_cidr_blocks :
    "${rule.from_port}-${rule.to_port}-${rule.protocol}-${rule.description}" => rule
  }

  security_group_id = aws_security_group.this.id
  type              = "ingress"

  cidr_blocks = each.value.cidr_blocks
  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
}

resource "aws_security_group_rule" "egress_with_cidr_blocks" {
  for_each = {
    for rule in var.egress_with_cidr_blocks :
    "${rule.from_port}-${rule.to_port}-${rule.protocol}-${rule.description}" => rule
  }

  security_group_id = aws_security_group.this.id
  type              = "egress"

  cidr_blocks = each.value.cidr_blocks
  description = each.value.description
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
}
