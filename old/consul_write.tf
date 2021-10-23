resource "consul_keys" "vpc_ip" {
  key {
    path  = "infra/${terraform.workspace}/network/vpc_ip"
    value = "${module.vpc.vpc_id}"
  }
}
