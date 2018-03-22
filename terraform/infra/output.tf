output "instance_public_ip" {
  value = "${module.compute.app_instance_eip}"
}
