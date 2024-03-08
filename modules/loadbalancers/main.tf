resource "aws_lb" "project_public" {
  name               = "un-lb-public1-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = var.public_subnets
  enable_deletion_protection = false
}

resource "aws_lb_listener" "project_public"{
    load_balancer_arn = aws_lb.project_public.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
        target_group_arn = aws_lb_target_group.project_status.arn
    }
}


#Lighting setup 

resource "aws_lb_target_group_attachment" "project_lighting" {

  target_group_arn = aws_lb_target_group.project_lighting.arn
  target_id = var.lighting_server_id
  port = 3000
}

resource "aws_lb_target_group" "project_lighting" {
  name             = "tf-project-lighting1-lb-tg"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
  target_type = "instance"
  health_check {
    path     = "/api/lights/health"
    protocol = "HTTP"
  }
}
resource "aws_lb_listener_rule" "lighting" {
  listener_arn = aws_lb_listener.project_public.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_lighting.arn
  }

  condition {
    path_pattern {
      values = ["/api/lights"]
    }
  }
  condition {
    host_header {
      values = ["${var.lighting_dns_name}"]
    }
  }
}


#Heating setup

resource "aws_lb_target_group_attachment" "project_heating" {

  target_group_arn = aws_lb_target_group.project_heating.arn
  target_id = var.heating_server_id
  port = 3000
}

resource "aws_lb_target_group" "project_heating" {
  name             = "tf-project-heating1-lb-tg"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
  target_type = "instance"
  health_check {
    path     = "/api/heating/health"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener_rule" "heating" {
  listener_arn = aws_lb_listener.project_public.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_heating.arn
  }

  condition {
    path_pattern {
      values = ["/api/heating"]
    }
  }

  condition {
    host_header {
      values = ["${var.heating_dns_name}"]
    }
  }
}


#Status setup

resource "aws_lb_target_group_attachment" "project_status" {

  target_group_arn = aws_lb_target_group.project_status.arn
  target_id = var.status_server_id
  port = 3000
}

resource "aws_lb_target_group" "project_status" {
  name             = "tf-project-status1-lb-tg"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
  target_type = "instance"
  health_check {
    path     = "/api/status/health"
    protocol = "HTTP"
  }
}


resource "aws_lb_listener_rule" "status" {
  listener_arn = aws_lb_listener.project_public.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_status.arn
  }

  condition {
    path_pattern {
      values = ["/api/status"]
    }
  }

  condition {
    host_header {
      values = ["${var.status_dns_name}"]
    }
  }
}


resource "aws_lb" "project_private" {
  name               = "un-lb-private1-tf"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = var.private_subnets
  enable_deletion_protection = false
}

resource "aws_lb_listener" "project_private"{
    load_balancer_arn = aws_lb.project_private.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
        target_group_arn = aws_lb_target_group.project_auth.arn
    }
}



resource "aws_lb_target_group" "project_auth" {
  name             = "tf-project-auth1-lb-tg"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id
  target_type = "instance"
  health_check {
    path     = "/api/status"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "project_auth" {

  target_group_arn = aws_lb_target_group.project_auth.arn
  target_id = var.auth_server_id
  port = 3000
}
resource "aws_lb_listener_rule" "auth" {
  listener_arn = aws_lb_listener.project_private.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_auth.arn
  }

  condition {
    path_pattern {
      values = ["/api/auth"]
    }
  }

  condition {
    host_header {
      values = ["${var.auth_dns_name}"]
    }
  }
}