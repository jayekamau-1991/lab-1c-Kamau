resource "aws_acme_certificate" "cert" {
  domain_name = "app.chewbacca-growl.com"
  validation_method = "DNS"

  subject_alternative_names = [
    "app.chewbacca-growl.com"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acme_certificate.cert.domain_validation_options[0].resource_record_name
  type    = aws_acme_certificate.cert.domain_validation_options[0].resource_record_type
  zone_id = var.zone_id  # This should be set to the Route 53 hosted zone ID
  ttl     = 60
  records = [aws_acme_certificate.cert.domain_validation_options[0].resource_record_value]
}