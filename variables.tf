variable vpc_name {
    type = string
}

variable cidr_range {
    type = string
}

variable availability_zones{
    type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}
variable table_name {
    type = list(string)
}

variable "hash_key" {
  description = "hash_key or partition key for this table"
}

variable "hash_key_type" {
  description = "type of hash_key or partition key for this table"
}

variable "key_name" {
  description = "key_name"
  sensitive = true
}

# variable "tag_name" {
#   type = string
#   description = "Name of server"
# }

# variable "subnet_id" {
#   type = string
#   description = "EC2s subnet"
# }

# variable "securitygroupid" {
#     type = list
#     description = "security group id for EC2"
# }