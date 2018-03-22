variable "tf_vpc_cidr_block" {
  default = "172.20.0.0/16"
}

variable "tf_aws_instance_type" {
    default 	= "t2.micro"
}
variable "tf_aws_image_id" {
    default     = "ami-25e7705c"    /* Centos 7.4*/
    #default 	= "ami-c7fb64be"    /* Centos 7 */
}

variable "tf_azs" {
    description = "Run EC2 instances in these availability zones"
    default     = "eu-west-1a,eu-west-1b,eu-west-1c"
}

variable "tf_azs_private_cidr_block" {
    description = "list of private subnet cidr blocks"
    default     = "172.20.1.0/24,172.20.2.0/24,172.20.3.0/24"
}

variable "tf_azs_public_cidr_block" {
    description = "list of public subnet cidr blocks"
    default     = "172.20.101.0/24,172.20.102.0/24,172.20.103.0/24"
}

variable "tf_public_subnets_count" {
    default 	= 3
}

variable "tf_app_instances_count" {
    default     = 1
}

##
## change this  if to your key's name to be able to ssh to the instance
##
variable "tf_key_name" {
    default = "ahegazi"
}

variable "tf_utas_sg1_name" {
    default = "utas_app_sg1"
}

# variable "vpc_id" {
#     default = "vpc-94d189f0"
# }