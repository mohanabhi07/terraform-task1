provider "aws"{
    region="eu-north-1"
}

resource "aws_vpc" "terraform-vpc"{
    cidr_block="10.0.0.0/16"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
    tags={
        Name="Terraform-vpc"
    }
}

resource "aws_internet_gateway" "terraform-igw" {
    vpc_id = aws_vpc.terraform-vpc.id
    tags = {
      Name="terraform-igw"
    }  
}

resource "aws_subnet" "public_subnet_a" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-north-1a"
  tags = {
    Name="public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-north-1b"
  tags = {
    Name="public_subnet_b"
  }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.terraform-vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform-igw.id

    }
    tags = {
      Name="public_route_table"
    }
}

resource "aws_route_table_association" "public_sub_asso-a" {
 subnet_id      = aws_subnet.public_subnet_a.id
 route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_sub_ass-b" {
 subnet_id      = aws_subnet.public_subnet_b.id
 route_table_id = aws_route_table.public_route_table.id
}

