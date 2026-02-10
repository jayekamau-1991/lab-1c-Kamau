resource "aws_lb" "example" {
  # Other configurations

  access_logs {
    bucket  = "my-access-logs-bucket"
    prefix  = "access-logs"
  }

  listener {
    # Enable HTTPS listener
    port     = 443
    protocol = "HTTPS"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.example.arn
    }
    certificate_arn = var.https_certificate_arn
  }
}