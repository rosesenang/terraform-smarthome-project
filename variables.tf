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

variable "desired" {
  type        = number
  description = "desired instance number"
}

variable "max" {
  type        = number
  description = "maximum instance number"
}

variable "min" {
  type        = number
  description = "minimum instance number"
}

variable "lt_id" {
    type = list
    description = "launch instance ids"
}

variable "placementgroupname" {
  type = list
}

variable "api" {
  type = list(string)
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