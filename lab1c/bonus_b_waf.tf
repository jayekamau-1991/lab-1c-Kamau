resource "aws_wafv2_web_acl" "kamaus_waf01" {
  name  = "kamaus-waf01"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 0

    action {
      block {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "kamaus-waf01-metrics"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = "kamaus-waf01"
  }
}

resource "aws_wafv2_web_acl_association" "kamaus_waf_alb01" {
  resource_arn = aws_lb.kamaus_alb01.arn
  web_acl_arn  = aws_wafv2_web_acl.kamaus_waf01.arn
}
