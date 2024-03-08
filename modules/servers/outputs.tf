output "EC2" {
  value = aws_instance.EC2
}

output "EC2_public_dns" {
  value = aws_instance.EC2.public_dns
}

output "EC2_private_dns" {
  value = aws_instance.EC2.private_dns
}
