include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/components/endpoint-service"
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-00000000"
  }
}

dependency "subnet" {
  config_path = "../subnet/private"
  mock_outputs = {
    subnet_ids = ["subnet-00000002", "subnet-00000003"]
  }
}

dependency "alb" {
  config_path = "../load-balance"
  mock_outputs = {
    lb_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:000000000000:loadbalancer/app/mock"
  }
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.subnet.outputs.subnet_ids
  internal   = true
  alb_arn    = dependency.alb.outputs.lb_arn

  listener_port         = 80
  listener_protocol     = "TCP"
  target_group_port     = 80
  target_group_protocol = "TCP"
}
