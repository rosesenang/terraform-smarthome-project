resource "aws_lb" "project" {
  name               = "un-lb-project-${var.privateorpublic}-tf"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = var.publicorprivatesubnet
  enable_deletion_protection = false
}

resource "aws_lb_listener" "project"{
    load_balancer_arn = aws_lb.project.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
        target_group_arn = aws_lb_target_group.project.arn
    }
}


resource "aws_lb_target_group" "project" {
  name             = "tf-project-${var.privateorpublic}2-lb-tg"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
  target_type = "instance"
}
resource "aws_lb_target_group_attachment" "project" {
  count = var.numbertocreate
  target_group_arn = aws_lb_target_group.project.arn
  target_id = var.serverid[count.index]
  port = 3000
}
resource "aws_lb_listener_rule" "project" {
  count = var.numbertocreate
  listener_arn = aws_lb_listener.project.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project.arn
  }

  condition {
    path_pattern {
      values = ["/api/${var.api[count.index]}"]
    }
  }
}