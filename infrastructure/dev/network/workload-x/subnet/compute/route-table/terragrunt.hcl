include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../../../modules/unit/route-table"
}

locals {
  name          = "${include.root.locals.project}-${include.root.locals.environment}-workload-x-compute-rt"
  tags          = merge(include.root.locals.common_tags, { SubnetType = "compute" })
  allowed_cidrs = include.root.locals.networks.workload_x_compute_allowed_cidrs
}

dependency "vpc" {
  config_path = "../../../vpc"
  mock_outputs = {
    vpc_id = "vpc-00000000"
  }
}

dependency "subnet" {
  config_path = "../core"
  mock_outputs = {
    subnet_ids = ["subnet-00000002", "subnet-00000003"]
  }
}

dependency "tgw" {
  config_path = "../../../../shared/transit-gateway"
  mock_outputs = {
    tgw_id = "tgw-00000000"
  }
}

dependencies {
  paths = ["../../../transit-gateway-attachment"]
}

inputs = {
  name       = local.name
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.subnet.outputs.subnet_ids
  routes = [for cidr in local.allowed_cidrs : {
    cidr_block         = cidr
    transit_gateway_id = dependency.tgw.outputs.tgw_id
  }]
  tags       = local.tags
}
