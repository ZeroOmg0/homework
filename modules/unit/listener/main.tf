resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  certificate_arn   = var.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = var.forward_target_group_arn
  }
}
