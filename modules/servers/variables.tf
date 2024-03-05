variable "key_name" {
    type = string
    description = "key_pair_name"
    sensitive = true
}

variable "tag_name" {
  type = string
  description = "Name of server"
}

variable "subnet_id" {
  type = string
  description = "EC2s subnet"
}

variable "securitygroupid" {
    type = list(string)
    description = "security group id for EC2"
}

variable "assoc_public_ip" {
    type = bool
    description = "public ip?"
}