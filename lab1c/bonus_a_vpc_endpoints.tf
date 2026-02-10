# VPC Endpoints Configuration

## VPC Interface Endpoints
resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = "your_vpc_id"
  service_name = "com.amazonaws.us-east-1.ssm"
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id       = "your_vpc_id"
  service_name = "com.amazonaws.us-east-1.ec2messages"
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id       = "your_vpc_id"
  service_name = "com.amazonaws.us-east-1.ssmmessages"
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id       = "your_vpc_id"
  service_name = "com.amazonaws.us-east-1.logs"
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id       = "your_vpc_id"
  service_name = "com.amazonaws.us-east-1.secretsmanager"
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id       = "your_vpc_id"
  service_name = "com.amazonaws.us-east-1.kms"
}

## S3 Gateway Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "your_vpc_id"
  service_name = "com.amazonaws.com/s3"
  route_table_ids = [
    "your_route_table_id"
  ]
}