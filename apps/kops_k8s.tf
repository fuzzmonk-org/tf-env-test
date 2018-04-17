
# terraform{} does not accept interpolation, so everything has to be hard coded
# don't forget that when you copy/paste this elsewhere!
terraform {
  required_version = ">= 0.11.0"
  backend "s3" {
    encrypt = true
    bucket = "terraform-remote-state-s3-test-apps"
    dynamodb_table = "terraform-state-lock-dynamodb-test-apps"
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


#################
# KOPS/Kubernetes
#################
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "terraform-remote-state-s3-test-vpc"
    key = "terraform.tfstate"
    region = "${var.region}"
  }
}

module "kops-k8s" {
  source = "../../tf-modules/kops-k8s"
  env = "${var.env}"

  kubernetes_ver = "${var.kubernetes_ver}"
  kops_s3 = "${var.kops_s3}"
  kops_iam = "${format("kops-%s", var.env)}"
  kops_name = "${format("kops-%s", var.env)}"

  kops_network = "${var.kops_network}"
  kops_topology = "${var.kops_topology}"

  kops_vpc = "${data.terraform_remote_state.vpc.vpc_id}"          
  kops_zones =  ["${data.terraform_remote_state.vpc.azs}"]
  kops_subnets = ["${data.terraform_remote_state.vpc.private_net}"]
  kops_utility_subnets = ["${data.terraform_remote_state.vpc.public_net}"]

  kops_master_size = "${var.kops_master_size}"
  kops_node_size = "${var.kops_node_size}"
  kops_node_count = "${var.kops_node_count}"

  kops_dns_type = "${var.kops_dns_type}"
  kops_dns_zone = "${var.kops_dns_zone}"

  kops_api_loadbalancer_type = "${var.kops_api_loadbalancer_type}"

}



/*

*/

