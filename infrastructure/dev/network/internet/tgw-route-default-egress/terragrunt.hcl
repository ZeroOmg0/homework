include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules/unit/transit-gateway-route"
}

dependency "tgw" {
  config_path = "../../shared/transit-gateway"
  mock_outputs = {
    tgw_default_route_table_id = "tgw-rtb-00000000"
  }
}

dependency "attachment" {
  config_path = "../transit-gateway-attachment"
  mock_outputs = {
    attachment_id = "tgw-attach-00000000"
  }
}

inputs = {
  route_table_id         = dependency.tgw.outputs.tgw_default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  attachment_id          = dependency.attachment.outputs.attachment_id
}
