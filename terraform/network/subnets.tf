resource "aws_subnet" "public-sub-1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "publicSubnet-1a"
  }

}

resource "aws_subnet" "public-sub-2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "publicSubnet-1b"
  }

}

resource "aws_subnet" "private-sub-1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = "false"
  tags = {
    "Name" = "privateSubnet-1a"
  }

}

resource "aws_subnet" "private-sub-2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = "false"
  tags = {
    "Name" = "privateSubnet-1b"
  }

}