/* Create the VPC */
resource "aws_vpc" "vpc" {
  cidr_block                       = "${var.vpc_cidr}"
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "${var.prefix_tag}-vpc"
  }
}

/* Create Subnets */
resource "aws_subnet" "demo-public-subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.sbn_cidr_1}"
  availability_zone = "${var.availability_zone_1}"

  tags = {
    Name = "${var.prefix_tag}-public-subnet"
  }
}

resource "aws_subnet" "demo-private-subnet" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.sbn_cidr_2}"
  availability_zone = "${var.availability_zone_2}"

  tags = {
    Name = "${var.prefix_tag}-private-subnet"
  }
}

/* Create Internet Gateway */
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.prefix_tag}-igw"
  }
}

/* Create Public Route Table */
resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.prefix_tag}-public-route-table"
  }
}

/* Create Private Route Table */
resource "aws_route_table" "private-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.prefix_tag}-private-route-table"
  }
}

/* Route To Internet */
resource "aws_route" "route_internet" {
  route_table_id         = "${aws_route_table.public-route-table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.vpc-igw.id}"
}

/* Associate Subnet with Public Route Table */
resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = "${aws_subnet.demo-public-subnet.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

/* Associate Subnet with Private Route Table */
resource "aws_route_table_association" "private-subnet-association" {
  subnet_id      = "${aws_subnet.demo-private-subnet.id}"
  route_table_id = "${aws_route_table.private-route-table.id}"
}

/* Create SSH Key Pair */
resource "aws_key_pair" "admin-key-pair" {
  key_name   = "${var.ssh_key_name}-key"
  public_key = "${var.ssh_public_key}"
}
