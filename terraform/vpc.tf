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

# NAT gateway
resource "aws_nat_gateway" "natgw" {
    allocation_id = "${aws_eip.eip.id}"
    subnet_id = "${aws_subnet.bionime_assi_private.id}"
}

resource "aws_eip" "eip" {

}
