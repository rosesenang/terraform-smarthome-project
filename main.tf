module "vpc" {
  source = "./modules/vpc"

  vpc_name           = var.vpc_name
  cidr_range         = var.cidr_range
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

module "security" {
    source = "./modules/security"
    vpc_id = module.vpc.vpc_id
}

module "dynamo" {
  count = 2
  source = "./modules/dynamo"
  table_name = var.table_name[count.index]
  hash_key = var.hash_key
  hash_key_type = var.hash_key_type
}

module "lightingEC2"{
  source = "./modules/servers"
  subnet_id   = module.vpc.public_subnets[0]
  securitygroupid      = module.security.security[*]
  assoc_public_ip = true
  key_name = var.key_name
  tag_name = "lighting"
}

module "heatingEC2" {
  source = "./modules/servers"
  subnet_id   = module.vpc.public_subnets[1]
  securitygroupid      = module.security.security[*]
  assoc_public_ip = true
  key_name = var.key_name
  tag_name = "heating"
}

module "statusEC2" {
    source = "./modules/servers"
  subnet_id   = module.vpc.public_subnets[2]
  securitygroupid      = module.security.security[*]
  assoc_public_ip = true
  key_name = var.key_name
  tag_name = "status"
}

module "authEC2" {
    source = "./modules/servers"
  subnet_id   = module.vpc.private_subnets[1]
  securitygroupid   = [module.security.security[2], module.security.security[3]]
  assoc_public_ip = false
  key_name = var.key_name
  tag_name = "auth"
}

module "loadbalancer" {
  source = "./modules/loadbalancers"
  public_subnets = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  security_group_id = module.security.security
  lighting_server_id = module.lightingEC2.EC2.id
  heating_server_id = module.heatingEC2.EC2.id
  status_server_id = module.statusEC2.EC2.id
  auth_server_id = module.authEC2.EC2.id
  vpc_id = module.vpc.vpc_id
  lighting_dns_name = module.lightingEC2.EC2_public_dns
  heating_dns_name = module.heatingEC2.EC2_public_dns
  status_dns_name = module.statusEC2.EC2_public_dns
  auth_dns_name = module.authEC2.EC2_private_dns
}

module "autoscaling" {
  count = 4
  source = "./modules/autoscaling"
  max = var.max
  min=var.min
  desired = var.desired
  vpc_zone_identify = element([module.vpc.public_subnets, module.vpc.private_subnets], count.index<=2?0:1)
  lt_id = var.lt_id[count.index]
  placementgroupname = var.placementgroupname[count.index]
}


