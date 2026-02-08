# Bonus-B ALB, TLS, WAF, and Monitoring Configuration Variables

variable "bonus_b_alb_name" {
  description = "The name of the Bonus-B Application Load Balancer"
  type = string
}

variable "bonus_b_tls_cert_arn" {
  description = "The ARN of the TLS certificate for Bonus-B"
  type = string
}

variable "bonus_b_waf_web_acl_id" {
  description = "The ID of the WAF Web ACL for Bonus-B"
  type = string
}

variable "bonus_b_monitoring_enabled" {
  description = "Enable monitoring for Bonus-B"
  type = bool
  default = false
}