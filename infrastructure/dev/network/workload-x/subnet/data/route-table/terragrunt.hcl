include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../../../modules/unit/route-table"
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-workload-x-data-rt"
  tags = merge(include.root.locals.common_tags, { SubnetType = "data" })
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
    subnet_ids = ["subnet-00000004", "subnet-00000005"]
  }
}

dependencies {
  paths = ["../../../transit-gateway-attachment"]
}

inputs = {
  name       = local.name
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.subnet.outputs.subnet_ids
  routes     = []
  tags       = local.tags
}
