output "vpc_id" {
  value = "${data.terraform_remote_state.vpc.vpc_id}"
}

output "azs" {
  value = "${data.terraform_remote_state.vpc.azs}"
}

output "private_net" {
  value = "${data.terraform_remote_state.vpc.private_net}"
}

output "public_net" {
  value = "${data.terraform_remote_state.vpc.public_net}"
}


