# VPC
resource "aws_vpc" "bionime_assi" {
    cidr_block = "10.0.0.0/16"
}


# Subnet
resource "aws_subnet" "bionime_assi_public" {
  vpc_id     = "${aws_vpc.bionime_assi.id}"
  cidr_block = "10.0.100.0/24"

  tags = {
    Name = "bionime_assi_public"
  }
}

resource "aws_subnet" "bionime_assi_private" {
  vpc_id     = "${aws_vpc.bionime_assi.id}"
  cidr_block = "10.0.200.0/24"

  tags = {
    Name = "bionime_assi_private"
  }
}

# This is here to avoid RDS has to in two subnet restriction
resource "aws_subnet" "bionime_assi_private_extra" {
  vpc_id     = "${aws_vpc.bionime_assi.id}"
  cidr_block = "10.0.201.0/24"

  tags = {
    Name = "bionime_assi_private_extra"
  }
}

resource "aws_main_route_table_association" "main_route_table" {
    vpc_id = "${aws_vpc.bionime_assi.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "private" {
    subnet_id = "${aws_subnet.bionime_assi_private.id}"
    route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private_extra" {
    subnet_id = "${aws_subnet.bionime_assi_private_extra.id}"
    route_table_id = "${aws_route_table.private.id}"
}

# Internet gateway

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.bionime_assi.id}"
    tags = {
        Name = "bionime_ass"
    }
}

resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.bionime_assi.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }
}

resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.bionime_assi.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.natgw.id}"
    }
}


# NAT gateway
resource "aws_nat_gateway" "natgw" {
    allocation_id = "${aws_eip.eip.id}"
    subnet_id = "${aws_subnet.bionime_assi_private.id}"
}

resource "aws_eip" "eip" {

}
