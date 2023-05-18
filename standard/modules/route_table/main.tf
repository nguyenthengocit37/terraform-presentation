resource "aws_route_table" "example" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "public_association" {
  for_each       = var.public_subnets
  subnet_id      = each.value
  route_table_id = aws_route_table.example.id
}
