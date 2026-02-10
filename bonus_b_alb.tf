# Assuming the current content before changes

resource "aws_lb" "example" {
  name                         = "example-alb"
  internal                     = false
  load_balancer_type          = "application"
  security_groups              = [aws_security_group.example.id]
  subnets                      = [aws_subnet.example1.id, aws_subnet.example2.id]

  # Access logs block
  access_logs {
    bucket  = aws_s3_bucket.access_logs.bucket
    prefix  = "my-alb-logs"
  }

  enable_deletion_protection = false

  # ... other configurations
}

# Uncommenting the HTTPS listener block
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.example.arn
  port              = 443
  protocol          = "HTTPS"

  certificate_arn   = aws_acm_certificate.example.arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}