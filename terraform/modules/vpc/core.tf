resource "aws_vpc" "utas_test_vpc" {
  cidr_block           = "${var.mod_vpc_cidr_block}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name           = "utas_test_vpc"
    ansible_filter = "app_utas"
  }
}
