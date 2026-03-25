include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../../../modules/unit/route-table"
}

locals {
  name       = "${include.root.locals.project}-${include.root.locals.environment}-workload-x-interfacing-rt"
  tags       = merge(include.root.locals.common_tags, { SubnetType = "interfacing" })
  tgw_routes = include.root.locals.networks.tgw_routes.workload_x
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
    subnet_ids = ["subnet-00000006", "subnet-00000007"]
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
  routes = dependency.tgw.outputs.tgw_id != null ? [for cidr in local.tgw_routes : {
    cidr_block         = cidr
    transit_gateway_id = dependency.tgw.outputs.tgw_id
  }] : []
  tags = local.tags
}
