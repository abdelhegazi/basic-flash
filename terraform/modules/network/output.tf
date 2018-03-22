
output "igw_id" {
    value = "${aws_internet_gateway.utas_app_igw.id}"
}

output "pubrt_id" {
    value = "${aws_route_table.utas_app_vpc_pubrt.id}"
}

output "pubsn_ids" {
    value = "${join(",", aws_subnet.utas_pubsn.*.id)}"
}
