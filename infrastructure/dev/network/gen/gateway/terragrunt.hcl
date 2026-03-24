include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/unit/internet-gateway"
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "vpc-00000000"
  }
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-gen-igw"
  tags = include.root.locals.common_tags
}

inputs = {
  name   = local.name
  vpc_id = dependency.vpc.outputs.vpc_id
  tags   = local.tags
}
