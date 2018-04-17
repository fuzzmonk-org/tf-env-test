### USER CREDS ###
credentials = "~/.aws/creds"
aws_profile = "default"
key_name = "aws_tmatsuo"
region = "us-east-1"
env = "test"


### NETWORK ###
cidr        = "172.19.0.0/16"
azs         = ["us-east-1a", "us-east-1c"]


### KOPS/KUBERNETES ###
kubernetes_ver = "1.8.6"

kops_s3 = "kops_k8s-state-s3-test"

kops_network = "calico"
kops_topology = "private"

kops_master_size = "t2.micro"
kops_node_size = "t2.micro"
kops_node_count = "3"

kops_dns_type = "private"
kops_dns_zone = "test.fuzzmonk.fun"

kops_api_loadbalancer_type = "internal"

