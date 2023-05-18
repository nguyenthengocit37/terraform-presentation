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

resource "aws_subnet" "public_subnet" {
  count                   = local.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = element(local.availability_zones, count.index % local.availability_zone_count)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = local.private_subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + local.public_subnet_count)
  availability_zone = element(local.availability_zones, count.index % local.availability_zone_count)

  tags = {
    Name = "private-subnet-${count.index}"
  }
}
