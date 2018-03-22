output "app_instances_ids" {
    # value = "${element(split(",", aws_instance.app_instances.*.id), 1)}"
    value = "${aws_instance.app_instances.*.id}"
}

output "app_instance_public_ip" {
    value = "${aws_instance.app_instances.*.public_ip}"
}

output "security_groups" {
    value = "${aws_instance.app_instances.*.security_groups}"
}


output "app_instance_sg1_id" {
    value = "${aws_security_group.app_instance_sg1.*.id}"
}

output "app_instance_eip" {
    value = "${aws_eip.app_instance_eip.public_ip}"
}
