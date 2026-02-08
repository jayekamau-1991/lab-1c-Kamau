resource "aws_iam_role" "ssm_role" {
  name               = "ssm_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      }
    ]
  })
}

resource "aws_iam_policy" "ssm_policy" {
  name        = "ssm_policy"
  description = "Policy to allow SSM actions"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:SendCommand",
          "ssm:StartSession",
          "ssm:TerminateSession",
          "ssm:DescribeSessions"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attachment" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

resource "aws_instance" "private_ec2_instance" {
  ami                    = "ami-0c55b159cbfafe78b" // Specify a valid AMI ID
  instance_type         = "t2.micro"
  subnet_id             = var.subnet_id  // Provide your subnet ID
  vpc_security_group_ids = [var.security_group_id]  // Provide your security group ID
  iam_instance_profile   = aws_iam_role.ssm_role.name
  tags = {
    Name = "PrivateEC2Instance"
  }
}