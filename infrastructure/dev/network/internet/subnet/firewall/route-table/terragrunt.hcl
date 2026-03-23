locals {
  name       = "${include.root.locals.project}-${include.root.locals.environment}-internet-firewall-rt"
  tags       = merge(include.root.locals.common_tags, { SubnetType = "firewall" })
  tgw_routes = include.root.locals.networks.tgw_routes.internet
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

dependency "subnet_firewall" {
  config_path = "../core"
  mock_outputs = {
    subnet_ids = ["subnet-00000002", "subnet-00000003", "subnet-00000004"]
  }
}

dependency "nat_gateway" {
  config_path = "../../../nat-gateway"
  mock_outputs = {
    nat_gateway_id = "nat-00000000"
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
  subnet_ids = dependency.subnet_firewall.outputs.subnet_ids
  tags       = local.tags

  routes = concat(
    [
      {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = dependency.nat_gateway.outputs.nat_gateway_id
      }
    ],
    [for cidr in local.tgw_routes : {
      cidr_block         = cidr
      transit_gateway_id = dependency.tgw.outputs.tgw_id
    }]
  )
}
