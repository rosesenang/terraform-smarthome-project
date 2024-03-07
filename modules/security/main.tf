
resource "aws_security_group" "project_public_ingress" {
  name        = "project_public_ingress"
  description = "Project security group"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "project_public" {
  security_group_id = aws_security_group.project_public_ingress.id

    cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "project_custom_ingress" {
  security_group_id = aws_security_group.project_public_ingress.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port   = 3000
  ip_protocol = "tcp"
  to_port     = 3000
  
}

resource "aws_vpc_security_group_ingress_rule" "project_ssh" {
  security_group_id = aws_security_group.project_public_ingress.id
  
  cidr_ipv4 = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

  
#finish setting up security groups and attach appropriate rules to the security groups


resource "aws_security_group" "project_public_egress" {
  name        = "project_public_egress"
  description = "Project security group"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "project_public_egress" {
  security_group_id = aws_security_group.project_public_egress.id
  from_port         = 0
  to_port           = 65535
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_security_group_rule" "project_public_egress2" {
  type = "egress"
  security_group_id = aws_security_group.project_public_egress.id
  to_port = 22
  from_port = 22
  protocol = "tcp"  # theortical cidr block from my address cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "project_private_ingress" {
  name        = "project_private_ingress"
  description = "Project security group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "project_private_ingress" {
  type = "ingress"
  security_group_id = aws_security_group.project_private_ingress.id
  to_port = 22
  from_port = 22
  protocol = "tcp"  # theortical cidr block from my address cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "project_private_egress" {
  name        = "project_private_egress"
  description = "Project security group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "project_private_egress" {
  type = "egress"
  security_group_id = aws_security_group.project_private_egress.id
  to_port = 0
  from_port = 0
  protocol = -1  # theortical cidr block from my address cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  cidr_blocks = ["0.0.0.0/0"]
}

