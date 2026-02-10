resource "aws_lb" "kamaus_alb01" {
  name               = "kamaus-alb01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = aws_subnet.chewbacca_public_subnets[*].id
  
  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "alb-access-logs"
    enabled = true
  }
  
  tags = {
    Name = "kamaus-alb01"
  }
}

resource "aws_lb_target_group" "kamaus_tg01" {
  name        = "kamaus-tg01"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.chewbacca_vpc01.id
  target_type = "instance"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  tags = {
    Name = "kamaus-tg01"
  }
}

resource "aws_lb_target_group_attachment" "ec2" {
  target_group_arn = aws_lb_target_group.kamaus_tg01.arn
  target_id        = aws_instance.chewbacca.id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.kamaus_alb01.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.kamaus_alb01.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.kamaus_acm_cert01.arn
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kamaus_tg01.arn
  }
  
  depends_on = [aws_acm_certificate.kamaus_acm_cert01]
}