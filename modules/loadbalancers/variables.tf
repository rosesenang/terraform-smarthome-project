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