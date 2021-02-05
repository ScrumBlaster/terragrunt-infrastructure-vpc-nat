output "private_subnet1" {
  value = aws_subnet.priv1.id
}

output "private_subnet2" {
  value = aws_subnet.priv2.id
}

output "private_subnet3" {
  value = aws_subnet.priv3.id
}

output "public_subnet1" {
  value = aws_subnet.pub1.id
}

output "public_subnet2" {
  value = aws_subnet.pub2.id
}

output "public_subnet3" {
  value = aws_subnet.pub3.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "igw_id" {
  value = aws_internet_gateway.main.id
}

output "route_table_id" {
  value = aws_route_table.public.id
}

output "vpc_info" {
  value = aws_vpc.main.*
}