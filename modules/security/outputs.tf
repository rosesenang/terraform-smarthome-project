output "security" {
    description = "security group to be used"
    value = [aws_security_group.project_public_ingress.id, aws_security_group.project_public_egress.id, aws_security_group.project_private_ingress.id, aws_security_group.project_private_egress.id]
}

