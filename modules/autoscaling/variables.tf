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


variable "vpc_zone_identify" {
    type = list
    description = "Subnet zones list"
}

variable "lt_id" {
    type = string
    description = "launch template ids to be provided from a list"
}

variable "placementgroupname" {
  type = string
  description = "placement group name for the list"
}