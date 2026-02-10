resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"
    assume_role_policy = jsonencode(
        {
            Version = "2012-10-17"
            Statement = [
                {
                    Action = "sts:AssumeRole"
                    Principal = {
                        Service = "lambda.amazonaws.com"
                    }
                    Effect = "Allow"
                    Sid = ""
                }
            ]
        }
    )
}

resource "aws_iam_policy" "lambda_policy" {
    name        = "lambda_policy"
    description = "IAM policy for Lambda to invoke Bedrock and publish to SNS"
    policy      = jsonencode(
        {
            Version = "2012-10-17"
            Statement = [
                {
                    Effect = "Allow"
                    Action = [
                        "sns:Publish"
                    ]
                    Resource = "*"
                },
                {
                    Effect = "Allow"
                    Action = [
                        "bedrock:Invoke"
                    ]
                    Resource = "*"
                }
            ]
        }
    )
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
    role       = aws_iam_role.lambda_role.name
    policy_arn = aws_iam_policy.lambda_policy.arn
}