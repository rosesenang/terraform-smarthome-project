# variable public_subnets {
#     type = list(string)
# }

# variable private_subnets {
#     type = list(string)
# }

# variable "vpc_id" {
#   type = string
# }

# variable security_group_id {
#     type = list(string)
# }

# variable lighting_server_id{
#     type = string
# }

# variable heating_server_id{
#     type = string
# }

# variable auth_server_id{
#     type = string
# }

# variable status_server_id{
#     type = string
# }

# variable lighting_dns_name{
#     type = string
# }

# variable heating_dns_name{
#     type = string
# }

# variable status_dns_name{
#     type = string
# }

# variable auth_dns_name{
#     type = string
# }


variable "internal" {
type = bool
description = "type of balancer"
}

variable security_group_id {
    type = list(string)
}

variable "publicorprivatesubnet" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable serverid {
    type = list(string)
}

variable "api" {
  type =  list(string)
}

variable "privateorpublic" {
    type = string
}

variable "numbertocreate" {
    type = number
}