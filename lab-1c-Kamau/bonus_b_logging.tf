resource "aws_s3_bucket" "alb_logs" {
  bucket = "kamaus-alb-logs-${data.aws_caller_identity.current.account_id}"
  tags = {
    Name = "kamaus-alb-logs"
  }
}

resource "aws_s3_bucket_versioning" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_caller_identity" "current" {}
