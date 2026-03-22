output "endpoint_service_name" {
  value = module.endpoint_service.endpoint_service_name
}

output "nlb_arn" {
  value = module.nlb.lb_arn
}

output "nlb_dns_name" {
  value = module.nlb.lb_dns_name
}

output "nlb_target_group_arn" {
  value = module.nlb_target_group.tg_arn
}

output "nlb_listener_arn" {
  value = module.nlb_listener.listener_arn
}
