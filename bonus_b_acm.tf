resource "acm_certificate" "example" {
  domain_name       = "app.kamaus-labs.online"
  validation_method = "DNS"
}