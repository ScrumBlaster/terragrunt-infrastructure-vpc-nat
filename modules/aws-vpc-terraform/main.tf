#-----------------------------------------------------------------------------------------------------------------------
# Backend


resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags  = merge(
  var.tags
  )
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags  = merge(
  var.tags
  )
}

#------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------

data "aws_availability_zones" "main" {
  state = "available"
}

resource "aws_subnet" "priv1" {
  availability_zone = data.aws_availability_zones.main.names[0]
  cidr_block        = var.priv_sub_cidr_block[0]
  vpc_id            = aws_vpc.main.id
  tags = {
    Name            = "Priv1",
    AZ              = data.aws_availability_zones.main.names[0]
  }
}

resource "aws_subnet" "priv2" {
  availability_zone = data.aws_availability_zones.main.names[1]
  cidr_block        = var.priv_sub_cidr_block[1]
  vpc_id            = aws_vpc.main.id
  tags = {
    Name            = "Priv2",
    AZ              = data.aws_availability_zones.main.names[1]
  }
}

resource "aws_subnet" "priv3" {
  availability_zone = data.aws_availability_zones.main.names[2]
  cidr_block        = var.priv_sub_cidr_block[2]
  vpc_id            = aws_vpc.main.id
  tags = {
    Name            = "Priv3",
    AZ              = data.aws_availability_zones.main.names[2]
  }
}

resource "aws_subnet" "pub1" {
  availability_zone       = data.aws_availability_zones.main.names[0]
  map_public_ip_on_launch = true
  cidr_block              = var.pub_sub_cidr_block[0]
  vpc_id                  = aws_vpc.main.id
  tags = {
    Name                  = "Pub1"
    AZ                    = data.aws_availability_zones.main.names[0]
  }
}

resource "aws_subnet" "pub2" {
  availability_zone       = data.aws_availability_zones.main.names[1]
  map_public_ip_on_launch = true
  cidr_block              = var.pub_sub_cidr_block[1]
  vpc_id                  = aws_vpc.main.id
  tags = {
    Name                  = "Pub2"
    AZ                    = data.aws_availability_zones.main.names[1]
  }
}

resource "aws_subnet" "pub3" {
  availability_zone       = data.aws_availability_zones.main.names[2]
  map_public_ip_on_launch = true
  cidr_block              = var.pub_sub_cidr_block[2]
  vpc_id                  = aws_vpc.main.id
  tags = {
    Name                  = "Pub3"
    AZ                    = data.aws_availability_zones.main.names[2]
  }
}

#------------------------------------------------------------------------------------------------------------
#ROUTE TABLES AND RULES
#------------------------------------------------------------------------------------------------------------


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "testttt"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "pub1" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.pub1.id
}

resource "aws_route_table_association" "pub2" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.pub2.id
}

resource "aws_route_table_association" "pub3" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.pub3.id
}

resource "aws_main_route_table_association" "main" {
  route_table_id = aws_route_table.public.id
  vpc_id = aws_vpc.main.id
}


