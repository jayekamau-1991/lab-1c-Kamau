resource "aws_instance" "chewbacca" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.chewbacca_private_subnets[0].id
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id]
  tags = {
    Name = "Chewbacca"
    Environment = "production"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y amazon-ssm-agent
    systemctl start amazon-ssm-agent
    EOF
}

resource "aws_iam_role" "chewbacca_role" {
  name = "chewbacca_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_policy" "chewbacca_policy" {
  name        = "chewbacca_policy"
  description = "Policy for Chewbacca EC2 instance"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter"
        ],
        Resource = ["arn:aws:ssm:${var.aws_region}:*:parameter/lab/db/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = [var.secrets_manager_secret_name]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  policy_arn = aws_iam_policy.chewbacca_policy.arn
  role       = aws_iam_role.chewbacca_role.name
}

data "aws_caller_identity" "current" {}