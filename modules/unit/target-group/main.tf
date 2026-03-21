resource "aws_lb_target_group" "this" {
  vpc_id      = var.vpc_id
  port        = var.port
  protocol    = var.protocol
  target_type = var.target_type

  health_check {
    interval            = lookup(var.health_check, "interval", null)
    path                = lookup(var.health_check, "path", null)
    port                = lookup(var.health_check, "port", null)
    healthy_threshold   = lookup(var.health_check, "healthy_threshold", null)
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold", null)
    timeout             = lookup(var.health_check, "timeout", null)
    protocol            = lookup(var.health_check, "protocol", null)
    matcher             = lookup(var.health_check, "matcher", null)
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}
