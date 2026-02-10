resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "kamaus-alb-5xx-errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "Alert when ALB has 5xx errors"

  dimensions = {
    LoadBalancer = aws_lb.kamaus_alb01.arn_suffix
  }

  alarm_actions = [aws_sns_topic.kamaus_alarms.arn]
}

resource "aws_sns_topic" "kamaus_alarms" {
  name = "kamaus-alb-alarms"
}

resource "aws_sns_topic_subscription" "kamaus_alarms_email" {
  topic_arn = aws_sns_topic.kamaus_alarms.arn
  protocol  = "email"
  endpoint  = "jayekamau@gmail.com"
}
