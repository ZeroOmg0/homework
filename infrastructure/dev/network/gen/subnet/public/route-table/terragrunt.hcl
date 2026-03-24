locals {
  name       = "${include.root.locals.project}-${include.root.locals.environment}-gen-public-rt"
  tags       = merge(include.root.locals.common_tags, { SubnetType = "public" })
  tgw_routes = include.root.locals.networks.tgw_routes.gen
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../../../modules/unit/route-table"
}

dependency "vpc" {
  config_path = "../../../vpc"
  mock_outputs = {
    vpc_id = "vpc-00000000"
  }
}

dependency "subnet_public" {
  config_path = "../core"
  mock_outputs = {
    subnet_ids = ["subnet-00000000", "subnet-00000001", "subnet-00000002"]
  }
}

dependency "igw" {
  config_path = "../../../gateway"
  mock_outputs = {
    igw_id = "igw-00000000"
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
  subnet_ids = dependency.subnet_public.outputs.subnet_ids
  tags       = local.tags

  routes = concat(
    [
      {
        cidr_block = "0.0.0.0/0"
        gateway_id = dependency.igw.outputs.igw_id
      }
    ],
    [for cidr in local.tgw_routes : {
      cidr_block         = cidr
      transit_gateway_id = dependency.tgw.outputs.tgw_id
    }]
  )
}
