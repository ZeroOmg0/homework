include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../../../modules/unit/subnet"
}

locals {
  compartment = read_terragrunt_config("../../../compartment.hcl")
  subnet_type = "firewall"

  name = "${include.root.locals.project}-${include.root.locals.environment}-${local.compartment.locals.compartment}-${local.subnet_type}"
  tags = merge(include.root.locals.common_tags, { SubnetType = local.subnet_type })
}

dependency "vpc" {
  config_path = "../../../vpc"
  mock_outputs = {
    vpc_id = "vpc-00000000"
  }
}

inputs = {
  name         = local.name
  vpc_id       = dependency.vpc.outputs.vpc_id
  subnet_cidrs = include.root.locals.networks[local.compartment.locals.network].subnet_cidrs[local.subnet_type]
  tags         = local.tags
}
