include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/unit/vpc"
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-internet"
  tags = merge(include.root.locals.common_tags, { SubnetType = "internet" })
}

inputs = {
  name       = local.name
  cidr_block = include.root.locals.networks.internet.cidr_block
  tags       = local.tags
}
