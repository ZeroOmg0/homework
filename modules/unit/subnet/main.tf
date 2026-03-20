data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = var.availability_zones != null ? var.availability_zones : slice(
    data.aws_availability_zones.available.names,
    0,
    length(var.subnet_cidrs)
  )

  az_cidr_map = zipmap(local.azs, var.subnet_cidrs)
}

resource "aws_subnet" "this" {
  for_each = local.az_cidr_map

  vpc_id                  = var.vpc_id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(var.tags, {
    Name = "${var.name}-${substr(each.key, -1, 1)}"
  })
}
