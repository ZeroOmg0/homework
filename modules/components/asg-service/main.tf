locals {
  name_prefix = "${var.project}-${var.environment}-${var.name}"
}

data "aws_ami" "al2023" {
  count       = var.ami_id == "" ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "security_group" {
  source = "../../unit/security-group"

  name   = "${local.name_prefix}-sg"
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks = length(var.allowed_cidr_blocks) > 0 ? [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  ] : []

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = var.common_tags
}

resource "aws_launch_template" "this" {
  name_prefix            = "${local.name_prefix}-"
  image_id               = var.ami_id != "" ? var.ami_id : data.aws_ami.al2023[0].id
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.security_group.security_group_id]
  user_data              = var.user_data != null ? base64encode(var.user_data) : null

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.common_tags, {
      Name = local.name_prefix
    })
  }

  tags = merge(var.common_tags, {
    Name = local.name_prefix
  })
}

module "asg" {
  source = "../../unit/autoscaling-group"

  name                      = local.name_prefix
  subnet_ids                = var.subnet_ids
  desired_capacity          = var.desired_capacity
  min_size                  = var.min_size
  max_size                  = var.max_size
  target_group_arns         = var.target_group_arns
  health_check_type         = length(var.target_group_arns) > 0 ? "ELB" : "EC2"
  health_check_grace_period = 60
  launch_template_id        = aws_launch_template.this.id
  launch_template_version   = aws_launch_template.this.latest_version
  tags                      = var.common_tags
}
