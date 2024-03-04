output vpc {
    value = module.vpc
}

output "security_groups"{
    value = module.security
}

output "dynamo_table" {
  value = module.dynamo
}