// Public Routing Table
resource "aws_route_table" "utas_app_vpc_pubrt" {
  vpc_id = "${var.mod_vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"  
    gateway_id = "${aws_internet_gateway.utas_app_igw.id}"
  }

  tags {
    Name           = "utas_app_vpc_pubrt"
    ansible_filter = "utas_app_vpc_pubrt"
  }
}

// Begin Public Subnet Creation
// public subnet
resource "aws_subnet" "utas_pubsn" {
  count             = "${var.mod_pubsn_count}"
  vpc_id            = "${var.mod_vpc_id}"
  cidr_block        = "${element(split(",", var.mod_public_cidr_block), count.index)}"
  availability_zone = "${element(split(",", var.mod_azs), count.index)}"

  tags {
    Name           = "utas_app_pubsn_${element(split(",", var.mod_azs), count.index)}"
    ansible_filter = "utas_app_pubsn_${element(split(",", var.mod_azs), count.index)}"
  }
}

resource "aws_route_table_association" "pubsn_routing" {
  count          = "${var.mod_pubsn_count}"
  subnet_id      = "${element(aws_subnet.utas_pubsn.*.id, count.index)}"
  route_table_id = "${aws_route_table.utas_app_vpc_pubrt.id}"
}
