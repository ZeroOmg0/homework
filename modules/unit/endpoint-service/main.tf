resource "aws_vpc_endpoint_service" "this" {
  acceptance_required        = var.acceptance_required
  network_load_balancer_arns = var.lb_arn
  allowed_principals         = var.allowed_principals
  tags                       = var.tags
}
