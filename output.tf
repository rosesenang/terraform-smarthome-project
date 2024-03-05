output vpc {
    value = module.vpc
}

output "security_groups"{
    value = module.security.security
}

output "dynamo_table" {
  value = module.dynamo
}

# output "EC2" {
#     value  = [module.lightingEC2.EC2.id, module.heatingEC2.EC2.id, module.statusEC2.EC2.id, module.authEC2.EC2.id]
# }

output "lightingEC2" {
  value = module.lightingEC2.EC2
  sensitive = true
}

output "heatingEC2" {
  value = module.heatingEC2.EC2
  sensitive = true
}

output "statusEC2" {
  value = module.statusEC2.EC2
  sensitive = true
}

output "authEC2" {
  value = module.authEC2.EC2
  sensitive = true
}