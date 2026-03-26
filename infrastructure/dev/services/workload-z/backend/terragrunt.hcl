include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../modules/components/asg-service"
}

dependency "vpc" {
  config_path = "../../../network/workload-z/vpc"
  mock_outputs = {
    vpc_id   = "vpc-00000000"
    vpc_cidr = "10.4.0.0/16"
  }
}

dependency "subnet" {
  config_path = "../../../network/workload-z/subnet/private"
  mock_outputs = {
    subnet_ids   = ["subnet-00000004", "subnet-00000005"]
    subnet_cidrs = ["10.4.0.0/20", "10.4.16.0/20", "10.4.32.0/20"]
  }
}

dependency "alb" {
  config_path = "../../../network/workload-z/load-balance"
  mock_outputs = {
    tg_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:000000000000:targetgroup/mock/0000000000000000"
  }
}

inputs = {
  name       = "workload-z-backend"
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.subnet.outputs.subnet_ids

  allowed_cidr_blocks = dependency.subnet.outputs.subnet_cidrs

  target_group_arns = [dependency.alb.outputs.tg_arn]

  user_data = <<-EOF
              #!/bin/bash
              nohup python3 -m http.server 80 >/var/log/http.log 2>&1 &
              EOF
}
