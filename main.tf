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