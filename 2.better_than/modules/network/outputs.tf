output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  value = aws_internet_gateway.main[0].id
}
