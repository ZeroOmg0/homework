output "lb_arn" {
  value = module.alb.lb_arn
}

output "lb_dns_name" {
  value = module.alb.lb_dns_name
}

output "tg_arn" {
  value = module.target_group.tg_arn
}

output "listener_arn" {
  value = module.listener.listener_arn
}

output "sg_id" {
  value = module.security_group.security_group_id
}
