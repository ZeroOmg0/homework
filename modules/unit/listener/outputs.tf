output "listener_arn" {
  value = aws_lb_listener.this.arn
}

output "listener_id" {
  value = aws_lb_listener.this.id
}
