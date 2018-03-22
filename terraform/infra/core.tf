
module "vpc" {
  source = "../modules/vpc"

  mod_vpc_cidr_block          = "${var.tf_vpc_cidr_block}"
}

module "network" {
  source = "../modules/network"

  mod_vpc_id                  = "${module.vpc.vpc_id}"
  mod_azs                     = "${var.tf_azs}"
  mod_pubsn_count             = "${var.tf_public_subnets_count}"
  mod_public_cidr_block       = "${var.tf_azs_public_cidr_block}"
  mod_app_sg1_id              = "${module.compute.app_instance_sg1_id}"
  mod_app_instances_ids       = "${module.compute.app_instances_ids}"  
}

module "compute" {
  source = "../modules/compute"

  mod_app_instances_count  = "${var.tf_app_instances_count}"
  mod_ami                  = "${var.tf_aws_image_id}"
  mod_instance_type        = "${var.tf_aws_instance_type}"
  mod_azs                  = "${var.tf_azs}"
  mod_pubsn_ids            = "${module.network.pubsn_ids}"
  mod_vpc_id               = "${module.vpc.vpc_id}"
  mod_app_sg1_name         = "${var.tf_utas_sg1_name}"
  mod_key_name             = "${var.tf_key_name}"
}
