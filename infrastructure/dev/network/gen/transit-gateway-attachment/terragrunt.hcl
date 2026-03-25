include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/components/transit-gateway-attachment"
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-00000000"
  }
}

dependency "subnet" {
  config_path = "../subnet/interfacing/core"
  mock_outputs = {
    subnet_ids = ["subnet-00000004", "subnet-00000005"]
  }
}

dependency "tgw" {
  config_path = "../../shared/transit-gateway"
  mock_outputs = {
    tgw_id                     = "tgw-00000000"
    tgw_default_route_table_id = "tgw-rtb-00000000"
  }
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-gen-tgw-attachment"
  tags = include.root.locals.common_tags
}

inputs = {
  name               = local.name
  tgw_id             = dependency.tgw.outputs.tgw_id
  vpc_id             = dependency.vpc.outputs.vpc_id
  subnet_ids         = dependency.subnet.outputs.subnet_ids
  route_table_id     = dependency.tgw.outputs.tgw_default_route_table_id
  tags               = local.tags
  enable_association = true
  enable_propagation = true
}
