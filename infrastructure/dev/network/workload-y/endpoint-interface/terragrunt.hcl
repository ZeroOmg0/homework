include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules/unit/endpoint-interface"
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id   = "vpc-00000000"
    vpc_cidr = "10.3.0.0/16"
  }
}

dependency "subnet" {
  config_path = "../subnet/private"
  mock_outputs = {
    subnet_ids = ["subnet-00000004", "subnet-00000005"]
  }
}

dependency "endpoint_service" {
  config_path = "../../workload-z/endpoint-service"
  mock_outputs = {
    endpoint_service_name = "com.amazonaws.vpce.ap-southeast-1.vpce-svc-00000000000000000"
  }
}

inputs = {
  vpc_id              = dependency.vpc.outputs.vpc_id
  subnet_ids          = dependency.subnet.outputs.subnet_ids
  service_names       = [dependency.endpoint_service.outputs.endpoint_service_name]
  security_group_name = "consumer-endpoint-sg"
  private_dns_enabled = false

  ingress_with_cidr_blocks = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [dependency.vpc.outputs.vpc_cidr]
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
