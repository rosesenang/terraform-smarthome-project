# output "alb_public" {
#     value = aws_lb.project_public
# }

# output "alb_private" {
#     value = aws_lb.project_private
# }

# output "dns_name_public" {
#     value = aws_lb.project_public.dns_name
# }

# output "dns_name_private" {
#     value = aws_lb.project_private.dns_name
# }

output "alb" {
    value = aws_lb.project
}

output "alb_arn" {
    value = aws_lb_target_group.project.arn
}

