locals {
  name_prefix = var.name
}

module "security_group" {
  source = "../../unit/security-group"

  name                     = "${local.name_prefix}-sg"
  vpc_id                   = var.vpc_id
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  egress_with_cidr_blocks  = var.egress_with_cidr_blocks
  tags                     = var.common_tags
}

module "alb" {
  source = "../../unit/load-balance"

  name                       = local.name_prefix
  internal                   = var.internal
  load_balancer_type         = "application"
  subnet_ids                 = var.subnet_ids
  security_group_ids         = [module.security_group.security_group_id]
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = var.common_tags
}

module "target_group" {
  source = "../../unit/target-group"

  name        = "${local.name_prefix}-tg"
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type
  health_check = var.health_check
  tags        = var.common_tags
}

module "listener" {
  source = "../../unit/listener"

  load_balancer_arn       = module.alb.lb_arn
  port                    = var.port
  protocol                = var.protocol
  certificate_arn         = var.certificate_arn
  ssl_policy              = var.ssl_policy
  forward_target_group_arn = module.target_group.tg_arn
}

resource "aws_lb_target_group_attachment" "ip_targets" {
  for_each = toset(var.target_ips)

  target_group_arn = module.target_group.tg_arn
  target_id        = each.key
  port             = var.port
}
