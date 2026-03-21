output "tg_arn" {
  value = aws_lb_target_group.this.arn
}

output "tg_id" {
  value = aws_lb_target_group.this.id
}
