
resource "aws_security_group" "project" {
  name        = "project"
  description = "Project security group"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "project_http_ipv6" {
  security_group_id = aws_security_group.project.id

  cidr_ipv6   = "::/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "project_http_ipv4" {
  security_group_id = aws_security_group.project.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "project_customport_ipv6" {
  security_group_id = aws_security_group.project.id

  cidr_ipv6   = "::/0"
  from_port   = 3000
  ip_protocol = "tcp"
  to_port     = 3000
}

resource "aws_vpc_security_group_ingress_rule" "project_port_ipv4" {
  security_group_id = aws_security_group.project.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 3000
  ip_protocol = "tcp"
  to_port     = 3000
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.project.id
  # theortical cidr block from my address cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  cidr_ipv4 = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.project.id
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv6" {
  security_group_id = aws_security_group.project.id

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv4" {
  security_group_id = aws_security_group.project.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}