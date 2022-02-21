provider "aws" {
  region = "ap-south-1"
   access_key = "AKIAYX3WYNWG7OJP4U75"
  secret_key = "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"
}

#vpc creation
resource "aws_vpc" "TEST" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

#Public subnet zone-1a
resource "aws_subnet" "PUBLIC_SUBNET_1A" {
  vpc_id     = aws_vpc.TEST.id
  cidr_block = var.PUBLIC_SUBNET_1a_CIDR
  availability_zone = "ap-south-1a"
  tags = {
    Name = var.PUBLIC_SUBNET_1A_NAME
  }
}

#Public subnet zone-1b
resource "aws_subnet" "PUBLIC_SUBNET_1B" {
  vpc_id     = aws_vpc.TEST.id
  cidr_block = var.PUBLIC_SUBNET_1b_CIDR
  availability_zone = "ap-south-1b"
  tags = {
    Name = var.PUBLIC_SUBNET_1B_NAME
  }
}

#Private subnet zone-1a
resource "aws_subnet" "PRIVATE_SUBNET_1A" {
  vpc_id     = aws_vpc.TEST.id
  cidr_block = var.PRIVATE_SUBNET_1a_CIDR
  availability_zone = "ap-south-1a"
  tags = {
    Name = var.PRIVATE_SUBNET_1A_NAME
  }
}

#Private subnet zone-1b
resource "aws_subnet" "PRIVATE_SUBNET_1B" {
  vpc_id     = aws_vpc.TEST.id
  cidr_block = var.PRIVATE_SUBNET_1b_CIDR
  availability_zone = "ap-south-1b"
  tags = {
    Name = var.PRIVATE_SUBNET_1B_NAME
  }
}

#Internet-gateway
resource "aws_internet_gateway" "TEST_IGW" {
  vpc_id = aws_vpc.TEST.id

  tags = {
    Name = var.IGW
  }
}

#eip creation for nat
resource "aws_eip" "nat_ip" {
  tags = {
    Name = var.nat_ip
  }
}


#NAT-gateway
resource "aws_nat_gateway" "test_nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.PUBLIC_SUBNET_1A.id

  tags = {
    Name = var.nat_gw
  }
}

#public route table 
resource "aws_route_table" "PUBLIC_ROUTE" {
  vpc_id = aws_vpc.TEST.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TEST_IGW.id
  }
  tags = {
    Name = var.public_route
  }
}
#private route 
resource "aws_route_table" "PRIVATE_ROUTE" {
  vpc_id = aws_vpc.TEST.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.test_nat_gateway.id
  }
  tags = {
    Name = var.private_route
  }
}

#public subnet association
resource "aws_route_table_association" "PUBLIC_SUBNET_ASSOCIATION" {
  count          = var.public_subnet_count
  subnet_id      = element(split(",", join(",", aws_subnet.PUBLIC_SUBNET_1A.*.id ,aws_subnet.PUBLIC_SUBNET_1B.*.id )), count.index)
  route_table_id = aws_route_table.PUBLIC_ROUTE.id
}

#PRIVATE SUBNET association
resource "aws_route_table_association" "PRIVATE_SUBNET_ASSOCIATION" {
  count          = var.public_subnet_count
  subnet_id      = element(split(",", join(",", aws_subnet.PRIVATE_SUBNET_1A.*.id ,aws_subnet.PRIVATE_SUBNET_1B.*.id )), count.index)
  route_table_id = aws_route_table.PRIVATE_ROUTE.id
}




























