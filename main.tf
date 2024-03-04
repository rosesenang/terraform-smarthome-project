module "vpc" {
  source = "./modules/vpc"

  vpc_name           = "project_vpc"
  cidr_range         = "10.0.0.0/20"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
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
