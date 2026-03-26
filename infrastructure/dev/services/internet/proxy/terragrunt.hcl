include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/components/asg-service"
}

dependency "vpc" {
  config_path = "../../../network/internet/vpc"
  mock_outputs = {
    vpc_id   = "vpc-00000000"
    vpc_cidr = "10.0.0.0/16"
  }
}

dependency "subnet" {
  config_path = "../../../network/internet/subnet/interfacing/core"
  mock_outputs = {
    subnet_ids = ["subnet-00000010", "subnet-00000011"]
  }
}

dependency "public_alb" {
  config_path = "../../../network/internet/load-balance"
  mock_outputs = {
    tg_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:000000000000:targetgroup/mock/0000000000000000"
  }
}

dependency "internal_alb" {
  config_path = "../../../network/workload-x/load-balance"
  mock_outputs = {
    lb_dns_name = "internal-alb.mock.local"
  }
}

locals {
  public_subnet_cidrs = include.root.locals.networks.internet.subnet_cidrs.public
}

inputs = {
  name       = "internet-proxy"
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.subnet.outputs.subnet_ids

  allowed_cidr_blocks = local.public_subnet_cidrs

  target_group_arns = [dependency.public_alb.outputs.tg_arn]

  user_data = <<-EOF
              #!/bin/bash
              dnf -y install nginx
              cat >/etc/nginx/conf.d/proxy.conf <<'CONF'
              server {
                listen 80;
                location / {
                  proxy_pass http://${dependency.internal_alb.outputs.lb_dns_name};
                  proxy_set_header Host $$host;
                  proxy_set_header X-Forwarded-For $$proxy_add_x_forwarded_for;
                }
              }
              CONF
              systemctl enable nginx
              systemctl restart nginx
              EOF
}
