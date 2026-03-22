output "endpoint_service_name" {
  description = "The service name of the VPC endpoint service (used by consumers)"
  value       = aws_vpc_endpoint_service.this.service_name
}
