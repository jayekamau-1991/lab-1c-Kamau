output "ec2_instance_id" {
  description = "The ID of the private EC2 instance"
  value     = aws_instance.private_instance.id
}

output "ec2_private_ip" {
  description = "The private IP address of the EC2 instance"
  value     = aws_instance.private_instance.private_ip
}

output "iam_role_arn" {
  description = "The ARN of the IAM role"
  value     = aws_iam_role.my_role.arn
}

output "vpc_endpoint_ids" {
  description = "The IDs of the VPC endpoints"
  value     = aws_vpc_endpoint.my_vpc_endpoints.*.id
}