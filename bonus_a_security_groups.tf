resource "aws_security_group" "private_ec2_sg" {
  name        = "private_ec2_sg"
  description = "Private EC2 Security Group allowing egress to VPC endpoints on port 443"
  vpc_id     = "<your_vpc_id>"  # Replace with your actual VPC ID

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks  = ["<your_vpc_endpoint_cidr>"]  # Replace with the CIDR block for your VPC endpoint.
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_https.id]
  }
}

resource "aws_security_group" "allow_https" {
  name        = "allow_https"
  description = "VPC Endpoint Security Group allowing inbound HTTPS (443) from EC2 Security Group"
  vpc_id     = "<your_vpc_id>"  # Replace with your actual VPC ID

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.private_ec2_sg.id]
  }
}