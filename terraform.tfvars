vpc_name           = "project_vpc"
cidr_range         = "10.0.0.0/20"
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
public_subnets     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
table_name = ["Lighting", "Heating"]
hash_key = "id"
hash_key_type = "N"
key_name = "project4keypair"
desired = 3
min = 2
max = 4
lt_id = [
  "lt-0102d82baeb60062c",
  "lt-008410bf1faf3c98f",
  "lt-08eecc3c5d1e6884d",
  "lt-0d63f711894fdb3ed",
]
placementgroupname = ["lightingPG", "heatingPG", "statusPG", "authPG"]