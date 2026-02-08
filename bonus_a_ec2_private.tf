# IAM Role for Production EC2 Instance

resource "aws_iam_role" "ec2_production_role" {
  name               = "ec2_production_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for the EC2 Role
resource "aws_iam_policy" "ec2_production_policy" {
  name        = "ec2_production_policy"
  description = "Policy for production EC2 instances to access necessary resources."
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::your-bucket-name/*"
      }
    ]
  })
}

# Attach the IAM Policy to the Role
resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = aws_iam_policy.ec2_production_policy.arn
  role       = aws_iam_role.ec2_production_role.name
}

# EC2 Instance
resource "aws_instance" "production_ec2" {
  ami                    = "ami-12345678"  # replace with your AMI ID
  instance_type         = "t2.micro"
  iam_instance_profile   = aws_iam_role.ec2_production_role.name
  vpc_security_group_ids = ["sg-12345678"]  # replace with your security group ID
  subnet_id             = "subnet-12345678"  # replace with your subnet ID
  key_name              = "your-key-name"  # replace with your key name
  tags = {
    Name = "ProductionEC2Instance"
  }
}