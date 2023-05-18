locals {
  availability_zone_count = length(var.availability_zones)
  availability_zones      = tolist(var.availability_zones)
  private_subnet_count    = var.num_private_subnets_per_az * local.availability_zone_count
  public_subnet_count     = var.num_public_subnets_per_az * local.availability_zone_count
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = var.vpc_tags
}

#=========== Subnet ===============

resource "aws_subnet" "public_subnet" {
  count                   = local.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, var.newbits, count.index)
  availability_zone       = element(local.availability_zones, count.index % local.availability_zone_count)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = local.private_subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.newbits, count.index + local.public_subnet_count)
  availability_zone = element(local.availability_zones, count.index % local.availability_zone_count)

  tags = {
    Name = "private-subnet-${count.index}"
  }
}

//========Internet gateway

resource "aws_internet_gateway" "main" {
  count  = var.create_internet_gateway ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = merge(var.local_tags, var.internet_gw_tags)
}

#=========== Route table ===============

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = length(aws_internet_gateway.main) > 0 ? aws_internet_gateway.main[0].id : null
  }

  tags = merge(var.local_tags, var.route_table_tags)
}

resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.public_subnet.*.id)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.example.id
}
