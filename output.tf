output vpc {
    value = module.vpc
}

output "security_groups"{
    value = module.security.security
}

output "dynamo_table" {
  value = module.dynamo
}

output "EC2_ids" {
    value  = [module.lightingEC2.EC2.id, module.heatingEC2.EC2.id, module.statusEC2.EC2.id, module.authEC2.EC2.id]
}

output "EC2_dns_name" {
    value  = ["lighting ${module.lightingEC2.EC2_public_dns}", "heating ${module.heatingEC2.EC2_public_dns}", "status ${module.statusEC2.EC2_public_dns}", "auth-private ${module.authEC2.EC2_private_dns}"]
}


output "autoscaling_group" {
  value = module.autoscaling[*].autoscaling
}