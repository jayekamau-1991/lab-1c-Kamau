output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.kamaus_alb01.dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.kamaus_alb01.arn
}

output "app_domain" {
  description = "Your app domain (HTTPS)"
  value       = "https://app.kamaus-labs.online"
}

output "target_group_arn" {
  description = "Target group ARN for EC2 instances"
  value       = aws_lb_target_group.kamaus_tg01.arn
}

output "route53_nameservers" {
  description = "Route53 nameservers - ADD THESE TO NAMECHEAP"
  value       = aws_route53_zone.kamaus_zone01.name_servers
}

output "waf_web_acl_arn" {
  description = "WAF Web ACL ARN attached to ALB"
  value       = aws_wafv2_web_acl.kamaus_waf01.arn
}

output "acm_certificate_arn" {
  description = "ACM Certificate ARN for HTTPS"
  value       = aws_acm_certificate.kamaus_acm_cert01.arn
}

output "s3_logs_bucket" {
  description = "S3 bucket for ALB access logs"
  value       = aws_s3_bucket.alb_logs.id
}

output "sns_topic_arn" {
  description = "SNS topic for ALB 5xx error alarms"
  value       = aws_sns_topic.kamaus_alarms.arn
}
