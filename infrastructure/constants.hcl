locals {
  project    = "homework"
  aws_region = "ap-southeast-1"
  common_tags = {
    Project   = local.project
    ManagedBy = "Terragrunt"
  }
  networks = {
    dev = {
      internet = {
        cidr_block = "10.0.0.0/16"
        subnet_cidrs = {
          public      = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
          firewall    = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
          interfacing = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]
        }
      }
      gen = {
        cidr_block = "10.1.0.0/16"
        subnet_cidrs = {
          public      = ["10.1.0.0/20", "10.1.16.0/20", "10.1.32.0/20"]
          interfacing = ["10.1.48.0/20", "10.1.64.0/20", "10.1.80.0/20"]
        }
      }
      workload_x = {
        cidr_block = "10.2.0.0/16"
        subnet_cidrs = {
          web         = ["10.2.0.0/20", "10.2.16.0/20", "10.2.32.0/20"]
          compute     = ["10.2.48.0/20", "10.2.64.0/20", "10.2.80.0/20"]
          data        = ["10.2.96.0/20", "10.2.112.0/20", "10.2.128.0/20"]
          interfacing = ["10.2.144.0/20", "10.2.160.0/20", "10.2.176.0/20"]
        }
      }
      workload_y = {
        cidr_block = "10.3.0.0/16"
        subnet_cidrs = {
          private = ["10.3.0.0/20", "10.3.16.0/20", "10.3.32.0/20"]
        }
      }
      workload_z = {
        cidr_block = "10.4.0.0/16"
        subnet_cidrs = {
          private = ["10.4.0.0/20", "10.4.16.0/20", "10.4.32.0/20"]
        }
      }
      workload_cidrs = ["10.2.0.0/16", "10.3.0.0/16", "10.4.0.0/16"]
      tgw_routes = {
        internet   = ["10.2.0.0/16"]
        gen        = ["10.2.0.0/16"]
        workload_x = ["10.0.0.0/16", "10.1.0.0/16"]
      }

      workload_x_web_tgw_routes        = ["10.0.0.0/16", "10.1.0.0/16"]
      # Compute subnet: configurable allowlist for TGW egress to other VPCs.
      workload_x_compute_allowed_cidrs = []
    }
  }
}
