include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/unit/network-firewall"
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-00000000"
  }
}

dependency "subnet" {
  config_path = "../subnet/firewall/core"
  mock_outputs = {
    subnet_ids = ["subnet-00000002", "subnet-00000003", "subnet-00000004"]
  }
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-internet-nfw"
  tags = include.root.locals.common_tags
}

inputs = {
  name       = local.name
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.subnet.outputs.subnet_ids
  tags       = local.tags
}
