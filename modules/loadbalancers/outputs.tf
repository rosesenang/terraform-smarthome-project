output "alb" {
    value = aws_lb.project
}

output "alb_arn" {
    value = aws_lb_target_group.project.arn
}

