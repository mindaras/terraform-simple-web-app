# aws_elb_service_account
data "aws_elb_service_account" "main" {}

# aws_lb
resource "aws_lb" "nginx" {
  name               = "${local.naming_prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx_alb_sg.id]
  subnets            = module.app.public_subnets
  depends_on         = [module.web_bucket]

  enable_deletion_protection = false

  access_logs {
    bucket  = module.web_bucket.bucket.id
    prefix  = "lb-logs"
    enabled = true
  }

  tags = local.common_tags
}

# aws_lb_listener 
resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = merge(local.common_tags, { Name = "${local.naming_prefix}-lb-listener" })
}

# aws_lb_target_group
resource "aws_lb_target_group" "nginx" {
  name     = "${local.naming_prefix}-nginx-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.app.vpc_id

  tags = local.common_tags
}

# aws_lb_target_group_attachment
resource "aws_lb_target_group_attachment" "nginx_attachments" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx_instances[count.index].id
  port             = 80
}