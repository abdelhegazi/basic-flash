#/* vpc_igw */
resource "aws_internet_gateway" "utas_app_igw" {
  vpc_id = "${var.mod_vpc_id}"

  tags {
    Name           = "utas_test_igw"
    ansible_filter = "utas_test_iwg"
  }
}
