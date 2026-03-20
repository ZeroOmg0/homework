locals {
  constants   = read_terragrunt_config(find_in_parent_folders("constants.hcl"))
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  project     = local.constants.locals.project
  aws_region  = local.constants.locals.aws_region
  environment = local.env_vars.locals.environment
  networks    = local.constants.locals.networks[local.env_vars.locals.environment]

  common_tags = merge(
    local.constants.locals.common_tags,
    { Environment = local.environment }
  )
}

remote_state {
  backend = "s3"

  config = {
    bucket         = "${local.project}-${local.environment}-tfstate-${local.aws_region}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "${local.project}-${local.environment}-tflock"
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<-EOF
    terraform {
      required_version = ">= 1.6.0"
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
    }

    provider "aws" {
      region = "${local.aws_region}"

      default_tags {
        tags = {
          Project     = "${local.project}"
          Environment = "${local.environment}"
          ManagedBy   = "Terragrunt"
        }
      }
    }
  EOF
}

inputs = {
  aws_region  = local.aws_region
  environment = local.environment
  project     = local.project
  common_tags = local.common_tags
}