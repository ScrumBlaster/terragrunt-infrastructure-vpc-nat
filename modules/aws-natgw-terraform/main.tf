#-----------------------------------------------------------------------------------------------------------------------
# Backend


resource "aws_eip" "nat" {
  count = var.how_many
}

resource "aws_nat_gateway" "main1" {
  allocation_id = aws_eip.nat[0].id
  subnet_id = var.public_subnets [0]
  tags = {
    Name = "NAT1a"
  }
}

resource "aws_nat_gateway" "main2" {
  allocation_id = aws_eip.nat[1].id
  subnet_id = var.public_subnets [1]
  tags = {
    Name = "NAT2b"
  }
}

resource "aws_nat_gateway" "main3" {
  allocation_id = aws_eip.nat[2].id
  subnet_id = var.public_subnets [2]
  tags = {
    Name = "NAT3c"
  }
}

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------

resource "aws_route_table" "toNAT1" {
  vpc_id = var.vpc_id
  tags = {
    Name = "NAT1a"
  }
}

resource "aws_route" "private1" {
  route_table_id         = aws_route_table.toNAT1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.main1.id
}

resource "aws_route_table_association" "a" {
  route_table_id = aws_route_table.toNAT1.id
  subnet_id = var.private_subnets [0]
}

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------


resource "aws_route_table" "toNAT2" {
  vpc_id = var.vpc_id
  tags = {
    Name = "NAT2b"
  }
}

resource "aws_route" "private2" {
  route_table_id         = aws_route_table.toNAT2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main2.id
}

resource "aws_route_table_association" "b" {
  route_table_id = aws_route_table.toNAT2.id
  subnet_id = var.private_subnets [1]
}

#-----------------------------------------------------------------------------

resource "aws_route_table" "toNAT3" {
  vpc_id = var.vpc_id
  tags = {
    Name = "NAT3c"
  }
}

resource "aws_route" "private3" {
  route_table_id         = aws_route_table.toNAT3.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id             = aws_nat_gateway.main3.id
}

resource "aws_route_table_association" "c" {
  route_table_id = aws_route_table.toNAT3.id
  subnet_id = var.private_subnets [2]
}
