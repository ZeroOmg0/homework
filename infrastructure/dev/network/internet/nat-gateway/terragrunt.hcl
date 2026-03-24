include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/unit/nat-gateway"
}

dependency "subnet" {
  config_path = "../subnet/public/core"
  mock_outputs = {
    subnet_ids = ["subnet-00000000", "subnet-00000001", "subnet-00000002"]
  }
}

locals {
  name = "${include.root.locals.project}-${include.root.locals.environment}-internet-nat"
  tags = include.root.locals.common_tags
}

inputs = {
  name      = local.name
  subnet_id = dependency.subnet.outputs.subnet_ids[0]
  tags      = local.tags
}
