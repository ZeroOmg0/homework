include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../modules/components/alb"
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-workload-x-alb-internal"
  tags = include.root.locals.common_tags
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id   = "vpc-00000000"
    vpc_cidr = "10.2.0.0/16"
  }
}

dependency "subnet" {
  config_path = "../subnet/web/core"
  mock_outputs = {
    subnet_ids = ["subnet-00000000", "subnet-00000001"]
  }
}

dependency "internet-vpc" {
  config_path = "../../internet/vpc"
  mock_outputs = {
    vpc_cidr = "10.0.0.0/16"
  }
}

dependency "gen-vpc" {
  config_path = "../../gen/vpc"
  mock_outputs = {
    vpc_cidr = "10.1.0.0/16"
  }
}

inputs = {
  name        = local.name
  vpc_id      = dependency.vpc.outputs.vpc_id
  subnet_ids  = dependency.subnet.outputs.subnet_ids
  internal    = true
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  target_ips  = []
  tags        = local.tags

  ingress_with_cidr_blocks = [
    {
      description = "Allow HTTP from workload-x"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [dependency.vpc.outputs.vpc_cidr]
    },
    {
      description = "Allow HTTP from internet compartment"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [dependency.internet-vpc.outputs.vpc_cidr]
    },
    {
      description = "Allow HTTP from GEN compartment"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [dependency.gen-vpc.outputs.vpc_cidr]
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
