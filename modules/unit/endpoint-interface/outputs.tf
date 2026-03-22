output "vpc_endpoint_interface_arn" {
  description = "Map of service name to VPC endpoint interface ARN"
  value = {
    for k, v in aws_vpc_endpoint.interface : k => v.arn
  }
}

output "vpc_endpoint_interface_dns_name" {
  description = "Map of service name to the first DNS name of the VPC endpoint interface"
  value = {
    for k, v in aws_vpc_endpoint.interface : k => v.dns_entry[0].dns_name
  }
}

output "vpc_endpoint_interface_ids" {
  description = "Map of service name to VPC endpoint interface ID"
  value = {
    for k, v in aws_vpc_endpoint.interface : k => v.id
  }
}
