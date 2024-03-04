resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  

  tags = {
    Name      = "${var.vpc_name}-privates ${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name      = "${var.vpc_name}-privates ${var.availability_zones[count.index]}"
  }
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "publicrt${var.vpc_name}"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_eip" "private_eip" {
  count = 3
  
  tags = {
    Name      = "private${var.vpc_name}, ${count.index}"
  }
}

resource "aws_nat_gateway" "privatenat" {
  count = length(var.public_subnets)
  allocation_id = aws_eip.private_eip[count.index].id
  connectivity_type                  = "public"
  subnet_id                          = element(aws_subnet.public[*].id, count.index)
  tags = {
    Name      = "private${count.index}"
  }
}