resource "aws_lb" "rearc" {
  name               = "rearc"
  internal           = false
  load_balancer_type = "application"
  security_groups    = []
  subnets            = []
 
  enable_deletion_protection = false
}
 
resource "aws_alb_target_group" "rearc" {
  name        = "rearc"
  port        = 80
  protocol    = "HTTP"
  # vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.rearc.id
  port              = 80
  protocol          = "HTTP"
 
  default_action {
   type = "redirect"
 
   redirect {
     port        = 443
     protocol    = "HTTPS"
     status_code = "HTTP_301"
   }
  }
}
 
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.rearc.id
  port              = 443
  protocol          = "HTTPS"
 
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = var.alb_tls_cert_arn
 
  default_action {
    target_group_arn = aws_alb_target_group.rearc.id
    type             = "forward"
  }
}
