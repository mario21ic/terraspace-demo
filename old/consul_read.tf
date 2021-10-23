data "consul_keys" "vpc_id" {
  key {
    name = "vpc_id"
    path = "infra/${terraform.workspace}/network/vpc_id"

    #default = ""
  }
}
