### USER CREDS ###
credentials = "~/.aws/creds"
aws_profile = "default"
key_name = "aws_tmatsuo"
region = "us-east-1"
env = "test"

### NETWORK ###
cidr        = "172.19.0.0/16"
azs         = ["us-east-1a", "us-east-1c"]
admin_net   = ["172.19.11.0/24", "172.19.12.0/24"]
build_net   = ["172.19.21.0/24", "172.19.22.0/24"]
private_net = ["172.19.31.0/24", "172.19.32.0/24"]
public_net  = ["172.19.41.0/24", "172.19.42.0/24"]

### DNS/DHCP ###
dns_ext_zone_name = "fuzzmonk.fun"
dns_int_zone_name = "fuzzmonk.internal"
ttl = "60"

bastion_ami_owner = "023775684211"
iam_instance_profile = "cloudwatch_instance_profile"