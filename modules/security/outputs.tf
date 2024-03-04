output "security" {
    description = "security group to be used"
    value = aws_security_group.project.id
}