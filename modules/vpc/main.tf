resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  
  tags = {
    Name      = "${var.vpc_name}-public ${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name      = "${var.vpc_name}-private ${var.availability_zones[count.index]}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name      = "${var.vpc_name}-igw"
  }
}

resource "aws_eip" "my_eip" {
  
  tags = {
    Name      = "private_eip_${var.vpc_name}"
  }
}

resource "aws_nat_gateway" "public_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  connectivity_type                  = "public"
  subnet_id = aws_subnet.public[0].id
  tags = {
    Name      = "public_nat_gateway"
  }
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name      = "publicrt${var.vpc_name}"
  }
}

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public_nat_gateway.id
  }
  tags = {
    Name      = "privatert${var.vpc_name}"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}




# resource "aws_route" "public_internet_gateway" {

#   route_table_id         = aws_route_table.public.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }
