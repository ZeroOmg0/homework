resource "aws_networkfirewall_firewall_policy" "this" {
  name = "${var.name}-policy"

  firewall_policy {
    stateless_default_actions          = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:pass"]
    stateful_default_actions           = ["aws:alert_strict"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-policy"
  })
}

resource "aws_networkfirewall_firewall" "this" {
  name                = var.name
  firewall_policy_arn = aws_networkfirewall_firewall_policy.this.arn
  vpc_id              = var.vpc_id

  dynamic "subnet_mapping" {
    for_each = var.subnet_ids
    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}

locals {
  # Production should use per-AZ
  endpoint_id = tolist([
    for sync_state in aws_networkfirewall_firewall.this.firewall_status[0].sync_states :
    sync_state.attachment[0].endpoint_id
  ])[0]
}
