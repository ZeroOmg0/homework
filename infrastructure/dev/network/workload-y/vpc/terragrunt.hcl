include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/unit/vpc"
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-workload-y"
  tags = include.root.locals.common_tags
}

inputs = {
  name       = local.name
  cidr_block = include.root.locals.networks.workload_y.cidr_block
  tags       = local.tags
}
