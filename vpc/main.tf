# terraform{} does not accept interpolation, so everything has to be hard coded
# don't forget that when you copy/paste this elsewhere!
terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    encrypt = true
    bucket = "terraform-remote-state-s3-test-vpc"
    dynamodb_table = "terraform-state-lock-dynamodb-test-vpc"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  version = "~> 1.12"
  region = "${var.region}"
  shared_credentials_file = "${var.credentials}"
  profile = "${var.aws_profile}"
}


###########
# VPC
###########

module "vpc" {
  source = "../../tf-modules/vpc"
  env = "${var.env}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  cidr_block = "${var.cidr}"
  azs = ["${var.azs}"]
  admin_net = ["${var.admin_net}"]
  build_net = ["${var.build_net}"]
  private_net = ["${var.private_net}"]
  public_net = ["${var.public_net}"]
  #key_name = "${var.key_name}"
  #bastion_ami = "${var.bastion_ami}"
}


###########
# BASTION
###########

module "bastion" {
  source = "../../tf-modules/bastion"
  key_name = "${var.key_name}"
  azs = ["${var.azs}"]
  bastion_ami_owner = "${var.bastion_ami_owner}"
  bastion_env = "${var.env}"
  bastion_vpc_id = "${module.vpc.vpc_id}"
  bastion_subnet = ["${module.vpc.public_net}"]
  dns_ext_zone_name = "${var.dns_ext_zone_name}"
  dns_int_zone_name = "${var.dns_int_zone_name}"
  ttl = "${var.ttl}"
  ig_id = "${module.vpc.ig_id}"
  iam_instance_profile = "${var.iam_instance_profile}"
}