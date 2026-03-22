locals {
  name_prefix = "${var.project}-${var.environment}-endpoint-service"
}

module "nlb" {
  source = "../../unit/load-balance"

  name                       = "${local.name_prefix}-nlb"
  internal                   = var.internal
  load_balancer_type         = "network"
  subnet_ids                 = var.subnet_ids
  security_group_ids         = []
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = var.common_tags
}

module "nlb_target_group" {
  source = "../../unit/target-group"

  name         = "${local.name_prefix}-tg"
  port         = var.target_group_port
  protocol     = var.target_group_protocol
  vpc_id       = var.vpc_id
  target_type  = "alb"
  health_check = var.health_check
  tags         = var.common_tags
}

module "nlb_listener" {
  source = "../../unit/listener"

  load_balancer_arn        = module.nlb.lb_arn
  port                     = var.listener_port
  protocol                 = var.listener_protocol
  certificate_arn          = var.certificate_arn
  ssl_policy               = var.ssl_policy
  forward_target_group_arn = module.nlb_target_group.tg_arn
}

resource "aws_lb_target_group_attachment" "alb" {
  target_group_arn = module.nlb_target_group.tg_arn
  target_id        = var.alb_arn
}

module "endpoint_service" {
  source = "../../unit/endpoint-service"

  lb_arn               = [module.nlb.lb_arn]
  acceptance_required  = var.acceptance_required
  allowed_principals   = var.allowed_principals
  tags                 = var.common_tags
}
