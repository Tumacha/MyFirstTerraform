# create vpc
resource "aws_vpc" "prod_vpc" {
  cidr_block       = "10.106.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod_vpc"
  }
}
# create private subnet
resource "aws_subnet" "Private_subnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.106.0.0/24"

  tags = {
    Name = "Private_subnet"
  }
}
# create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.106.1.0/24"

  tags = {
    Name = "public_subnet"
  }
}
# create internet gateway
resource "aws_internet_gateway" "prod_ig" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "prod_ig"
  }
}
# create route table
resource "aws_route_table" "prod_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_ig.id
  }

  tags = {
    Name = "prod_rt"
  }
}
# route table association to public subnet
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.prod_rt.id
}
# resource "aws_route_table_association" "b" {
#   gateway_id     = aws_internet_gateway.foo.id
#   route_table_id = aws_route_table.bar.id
# }
